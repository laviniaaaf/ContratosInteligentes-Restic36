// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {

    // Tipos de variáveis
    uint public storedValue;     // Tipo uint (inteiro sem sinal)
    int public signedValue;      // Tipo int (inteiro com sinal)
    string public storedString; // Tipo string
    address public owner;      // Tipo address (endereço de um usuário)
    bool public isActive;        // Tipo bool (valor booleano)

    // Construtor (executado uma vez na criação do contrato)
    constructor() {
        owner = msg.sender; // O dono do contrato é quem o criou
        storedValue = 0;
        signedValue = 0;
        storedString = "Texto inicial";
        isActive = true;
    }

    // Arrays e mappings (coleções de dados)
    uint[] public numbers; // Array de uint
    mapping(address => uint) public balances; // Mapeamento de endereços para saldos

    // Modificador de acesso
    modifier onlyOwner() {
        require(msg.sender == owner, "Somente o dono pode executar");
        _;
    }

    // Função para setar um valor
    function setValue(uint newValue) public {
        storedValue = newValue;
    }

    function getAddress() public view returns (address) {
        return owner;
    }

    // Função para obter um valor
    function getValue() public view returns (uint) {
        return storedValue;
    }

    // Função para alterar o valor de uma string
    function setString(string memory newString) public {
        storedString = newString;
    }

    // Função para adicionar um número no array
    function addNumber(uint num) public {
        numbers.push(num);
    }

    // Função para verificar a existência de um número no array
    function containsNumber(uint num) public view returns (bool) {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] == num) {
                return true; // Encontrado
            }
        }
        return false; // Não encontrado
    }

    // Função condicional simples
    function toggleActive() public {
        if (isActive) {
            isActive = false; // Se estiver ativo, desativa
        } else {
            isActive = true; // Se estiver inativo, ativa
        }
    }

    // Função para manipulação de mapeamento
    function updateBalance(address user, uint amount) public {
        require(amount > 0, "O valor deve ser maior que zero");
        balances[user] = amount;
    }

    // Função para verificar o saldo de um usuário
    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }

    // Laço de repetição com for
    function sumNumbers() public view returns (uint total) {
        total = 0;
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
    }

    // Laço de repetição com while
    function findMaxNumber() public view returns (uint max) {
        require(numbers.length > 0, "Array vazio");
        uint i = 0;
        max = numbers[i];
        while (i < numbers.length) {
            if (numbers[i] > max) {
                max = numbers[i];
            }
            i++;
        }
    }

    // Exemplo de uso de require para validar a execução
    function safeSubtract(uint a, uint b) public pure returns (uint) {
        require(a >= b, "O valor de 'a' deve ser maior ou igual a 'b'");
        return a - b;
    }

    // Função para destruir o contrato (somente o dono pode fazer isso)
    function destroy() public onlyOwner {
        selfdestruct(payable(owner)); // Autodestrói o contrato e envia saldo para o dono
    }

}
