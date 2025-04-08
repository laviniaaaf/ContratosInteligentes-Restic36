// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Criar um contrato inteligente
// Marketplace de Produtos e Servicos com Smart Contracts

// Funcionalidades 
//  1 - Cadastrar produtos ou servicos
//  2 - Comprar produtos/servicos
//  3 - Status de disponibilidade dos itens
//  4 - Evento para transacoes
//  5 - Protecoes contra acoes indevidas

contract Marketplace {
    
    address public owner;

    constructor() {
        owner = msg.sender;
    }
