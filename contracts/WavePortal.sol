// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // Um evento é um membro herdável do contrato, que armazena os argumentos passados ​​nos logs de transações quando emitidos.
    event NewWave(address indexed from, uint256 timestamp, string message);

    // Tipo de dados onde é possível customizar seu conteúdo
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    // Declara a variável waves que vai ser um array do struct Waves
    Wave[] waves;

    constructor() payable {
        console.log("Ueba, eu sou um contrato e eu sou inteligente");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s tchauzinho com a mensagem %s ", msg.sender, _message);

        // Armazena o tchauzinho no array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Tentando sacar mais dinheiro do que possui"
        );

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Falhou em sacar dinheiro do contrato.");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Temos um total de %d tchauzinhos ", totalWaves);
        return totalWaves;
    }
}