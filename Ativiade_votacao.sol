// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Votacao {
    struct Pessoa {
        uint id;        
        string nome;    
        bool votou;     
    }
 
    Pessoa[] public pessoas;

    mapping(address => bool) public cadastrados;  // verificar se um endereço já foi cadastrado

    string[] public itens;      //  itens (opções de voto)

    mapping(string => uint) public votos;   // armazenamento da contagem de votos por item

    string message = "inicio da votacao \n qual o seu sorvete preferido?";

    function mensagem() public view returns(string memory){
        return message;
    }

  
    function adicionarPessoaVotacao(string memory _nome) public {
        for (uint i = 0; i < pessoas.length; i++) {
            require(keccak256(abi.encodePacked(pessoas[i].nome)) != keccak256(abi.encodePacked(_nome)), "Pessoa ja cadastrada.");
         }
    
        pessoas.push(Pessoa(pessoas.length, _nome, false)); // Adiciona a pessoa à lista
    }

    
    function nomes() public view returns (string[] memory) {
        string[] memory nomespessoas = new string[](pessoas.length); 
    
        for (uint i = 0; i < pessoas.length; i++) {
            nomespessoas[i] = pessoas[i].nome;  
        }
    
        return nomespessoas;  
    }


    function adicionarItem(string memory _item) public {
        itens.push(_item); 
        votos[_item] = 0;  
    }

    function verItens() public view returns (string[] memory) {
        string[] memory listaItens = new string[](itens.length);  
    
        for (uint i = 0; i < itens.length; i++) {
            listaItens[i] = itens[i];  
        }
    
        return listaItens;  
    }

    function votar(string memory _nome, string memory _item) public {
        
        bool pessoaEncontrada = false;
        bool itemEncontrado = false;

        for (uint i = 0; i < pessoas.length; i++) {
            if (keccak256(abi.encodePacked(pessoas[i].nome)) == keccak256(abi.encodePacked(_nome))) {
                pessoaEncontrada = true;
                break;
            }
        }
        require(pessoaEncontrada, "Pessoa nao encontrada!");

        for (uint j = 0; j < itens.length; j++) {
            if (keccak256(abi.encodePacked(itens[j])) == keccak256(abi.encodePacked(_item))) {
                votos[_item]++;
                itemEncontrado = true;
                break;
            }
        }
        require(itemEncontrado, "Item nao encontrado!");
            
        
    }

    function resultadoFinal() public view returns (string[] memory, uint[] memory) {
        
        uint[] memory resultados = new uint[](itens.length);
        
        for (uint i = 0; i < itens.length; i++) {
            resultados[i] = votos[itens[i]];          
        }
        
        return (itens, resultados);        
    }
}
