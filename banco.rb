require_relative 'pessoa'
require 'json'
require 'active_support/core_ext/hash/keys'
require 'io/console'

class Banco

    def initialize
        @contas = carregar_contas || {}
        @contador_id = (@contas.keys.map(&:to_i).max || 0) + 1 #o &:to_i é uma forma abreviada de chamar um método para cada item de uma coleção (hash ou array).
        
        welcome
    end

    def welcome
        
        puts "\n   #############################################################"
        puts "   #                                                           #"
        puts "   #                  ____      ___    __   __                 #"
        puts "   #                 |  _ \\   /  _  \\\  \\ \\ / /                 #"
        puts "   #                 | |_) |  | | ) |   \\ V /                  #"
        puts "   #                 |  _ <   | |_) |   |   |                  #"
        puts "   #                 |_| \\_\\   \\___/   /_/^\\_\\ Pay             #"
        puts "   #                                                           #"
        puts "   #                     Bem-vindo ao RoxPay!                  #"
        puts "   #              Um banco simples para você controlar         #"
        puts "   #                   suas finanças no terminal.              #"
        puts "   #                                                           #"
        puts "   #                   Aperte Espaço para iniciar               #"
        puts "   #############################################################\n"

        press_enter

      end
      
    def press_enter
        loop do
            tecla = STDIN.getch
            case tecla
            when "\r"
                options
            end           
        end
    end

    def user_data
        puts "Digite o nome do usuário:"
        nome = gets.chomp
        puts "Digite a idade do usuário:"
        idade = gets.chomp.to_i

        create_account nome, idade
    end

    def gerar_id 
        id = @contador_id
        @contador_id += 1
        id
    end

    def create_account nome, idade, saldo = 10
        
        pessoa = Pessoa.new nome, idade
        puts "Criando conta para #{nome}."
        numero = gerar_id
        @contas[numero] = {
            pessoa: pessoa,
            saldo: saldo
        }

        puts ; puts "Conta criada com sucesso! ID da sua conta #{numero}"
        save_account
    end

    def show_options

        puts "\n   #############################################################"
        puts "   #                                                           #"
        puts "   #                      Barra de Opções:                     #"
        puts "   #                     Digite 0 para sair.                   #"
        puts "   #                   Digite 1 para criar conta.              #"
        puts "   #                  Digite 2 para transferir.                #"
        puts "   #   Digite 3 para mostrar dados (mostra todos os usuários). #"
        puts "   ##############################################################\n"
    
    end

    def options
        loop do
            show_options
            resposta = gets.chomp.to_i
            
            case resposta
            when 1
                user_data
            when 2
                exe_transfer
            when 3
                show_data_user
            when 4
                file_remove_json
            when 0
                puts "Saindo..."
                exit
            else
                puts "Opção inválida, tente novamente."
            
            end
        
        end

    end

    def exe_transfer
        puts "Digite o ID da conta de origem:"
        conta_origem = gets.chomp.to_i
        puts "Digite o ID da conta de destino:"
        conta_destino = gets.chomp.to_i
        puts "Digite o valor para transferir:"
        valor = gets.chomp.to_i
        
        if transfer(conta_origem, conta_destino, valor)
            puts "Transferência de R$#{valor} realizada com sucesso!"
            salvar_contas
        else
            puts "Falhou. Verifique os IDs e o saldo da conta de origem."
        end
    end

    def transfer(origem, destino, valor)
        conta_origem = @contas[origem]
        conta_destino = @contas[destino]

        if conta_origem && conta_destino && conta_origem[:saldo] >= valor
            conta_origem[:saldo] -= valor
            conta_destino[:saldo] += valor
            true
        else
            false
        end

    end

    def show_data_user
        @contas.each do |chave, valor|
            nome = valor[:pessoa].nome
            puts "ID: #{chave}, Nome: #{nome}, Saldo: R$#{valor[:saldo]}"
        end
    end

    def save_account
        File.write('contas.json', JSON.dump(@contas))
    end

    def carregar_contas
        if File.exist?('contas.json')
          JSON.parse(File.read('contas.json')).transform_values do |dados|
            dados['pessoa'] = Pessoa.new(dados['pessoa']['nome'], dados['pessoa']['idade'])
            dados.symbolize_keys
        
          end
        
        end
    
    end
    
    def file_remove_json 
        file_path = "contas.json"

        if File.exist?(file_path)
            File.delete(file_path)
        else
            puts "#{file_path} não existe."
        end
    end

end

banco = Banco.new
