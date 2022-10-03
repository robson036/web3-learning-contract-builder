const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory(
        "WavePortal"
    )
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    })
    await waveContract.deployed()
    console.log("Endereço do contrato: ", waveContract.address)

    // consulta saldo do contrato
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    )

    console.log(
        "Saldo do contrato: ",
        hre.ethers.utils.formatEther(contractBalance)
    )

    // Envia um tchauzinho
    let waveTxn = await waveContract.wave("Uma mensagem!")
    await waveTxn.wait()

    // Recupera o saldo do contrato para verificar o que aconteceu
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address)

    console.log(
        "Saldo do contrato: ",
        hre.ethers.utils.formatEther(contractBalance)
    )

    let allWaves = await waveContract.getAllWaves()
    console.log(allWaves)
}

const runMain = async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.error(error)
        process.exit(1)
    }
}

runMain()
