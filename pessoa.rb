class Pessoa
    attr_accessor :nome, :idade
end

=begin 
pessoa = Pessoa.new
pessoa.nome = "João"
pessoa.idade = 18

puts pessoa.nome
puts pessoa.idade
=end

=begin
pensando na inserção de hash
meu_hash = {}
meu_hash = { :um => 1, :dois => 2, :tres => 3 }

meu_hash.each do |chave, valor|
  puts "A posição #{chave} guarda o valor #{valor}"
end
=end