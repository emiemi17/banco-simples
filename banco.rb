require_relative 'pessoa'

class Banco
f initialize
        @usuarios = []
        @saldo = 100 #cada usuário iniciará com um saldo de 100 reais
        bem_vindo
        puts "olá " 
    end

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
    end

    def opcoes
        puts "Olá! Você está na aba de criação de conta."
        loop do
            puts "\nDigite 1 para criar conta ou 0 para sair."

            puts "Digite 2 para consultar dados" unless @usuarios.empty?
            resp = gets.chomp.to_i
            case resp
            
            when 1
                #poderia ter uma função entrada_dados_conta
                entrada_dados_conta
            
            when 2
                if @usuarios.empty?
                    puts "Vá criar uma conta, rapá -_- "
                else
                    puts "Digite o nome do usuário para consulta:"
                    n = gets.chomp
                    consulta_dados n
                end

            when 0
                puts "Saindo"
                break 
            
            else
                puts "Opção inválida, tente novamente."
            
            end
        
        end

    end

    def entrada_dados_conta
        puts "Digite o nome do usuário:"
        n = gets.chomp
        puts "Digite a idade do usuário:"
        i = gets.chomp.to_i
        criar_conta n, i
    end

    def criar_conta nome, idade
        pessoa = Pessoa.new
        pessoa.nome = nome
        pessoa.idade = idade
        @usuarios << pessoa
        puts "Usuário criado com sucesso. Olá, #{pessoa.nome}!"
    end

    def consulta_dados nome
        usuario = @usuarios.find {|p| p.nome == nome} #p é uma instância da class Pessoa
        if usuario
            puts "Seus Dados:"
            puts "Nome do usuário: #{usuario.nome}"
            puts "Idade do usuário: #{usuario.idade}"
            puts "Seu saldo: #{@saldo}"
        else
            puts "Usuário não encontrado."
        end
    end

    

end

banco = Banco.new