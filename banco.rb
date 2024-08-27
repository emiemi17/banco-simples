require_relative 'pessoa'

class Banco
    def initialize
        @contas = {}
        seja_bem_vindo
        mostrando_dados_criados
    end

    def seja_bem_vindo
        print "\n=========Olá! Seja Bem-vindo ao Banco de Terminal=========\n\n"
        print "=========Você tem as seguintes opções:=========\n"
        opcoes
    end

    def entrada_dados_conta
        puts "Digite o nome do usuário:"
        nome = gets.chomp
        puts "Digite a idade do usuário:"
        idade = gets.chomp.to_i
        puts "Digite o número da conta:"
        numero_conta = gets.chomp.to_i

        criar_conta nome, idade, numero_conta
    end

    def criar_conta nome, idade, numero, saldo = 100
        
        pessoa = Pessoa.new nome, idade
        @contas[numero] = {
            :pessoa => pessoa,
            :saldo => saldo
        }
        puts ; puts "Conta criada com sucesso!"
    end

    def opcoes
        loop do
            puts "\nDigite 1 para criar conta ou 0 para sair."
            resposta = gets.chomp.to_i
            case resposta
            when 1
                entrada_dados_conta
            when 0
                puts "Saindo"
                break 
            else
                puts "Opção inválida, tente novamente."
            
            end
        
        end

    end

    def mostrando_dados_criados
        @contas.each do |chave, valor|
            puts "#{chave}: #{valor}"
        end
    end
end

banco = Banco.new

=begin
def bem_vindo
        puts "\n====Bem-vindo ao Banco de Terminal===="
        puts "\nQuer continuar e criar uma conta no nosso Banco? Sim(s) ou Não(n)."
        resp = gets.chomp.downcase
        if resp == "sim" or resp == "s"
            opcoes
        elsif resp == "não" or resp == "n"
            puts "Obrigado pela atenção!"
            return
        else
            puts "Responda SOMENTE com sim ou não."
            bem_vindo
        end
=end
