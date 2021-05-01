const { assert } = require('chai')
const { default: Web3 } = require('web3')

const BankNegara = artifacts.require('BankNegara');

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('BankNegara', (accounts) =>{

    let banknegara;
    const deposit = web3.utils.toBN(2);

    before(async () => {
        banknegara = await BankNegara.deployed();
    })

    describe('deployment', async () => {
        // it method checks the specific task
        it('deploys successfully', async () => {
            // check if the address is valid
            const address = await BankNegara.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
         //checks default threshold should be 10 ether
        it('default threshold', async () => {
            const threshold = await banknegara.threshold()
            assert.equal(threshold, 10000000000000000000)
        })
    })

    describe('should deposit successfully', async () => {

        it('should deploy successfully and compare with balance', async () => {
            await banknegara.deposit( {from : accounts[1], value:100});
            const balance = await banknegara.balance({from:accounts[1]});
            assert.equal(100, balance);
        })
    })

    it('Should deploy contract properly...', async () =>{
        
        console.log('Here is the contract address ;');
        console.log(banknegara.address);
        assert(banknegara.address !== '');
    });

});