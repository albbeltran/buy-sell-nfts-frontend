let btnWallet = document.getElementById('btn-wallet');
let account = document.getElementById('account');
let balance = document.getElementById('balance');
let address;

// if Metamask is not available
if (typeof window.ethereum == 'undefined') {
    alert("You should install Metamask to use it!");
}

// Web3 instance
let web3 = new Web3(window.ethereum);

connectWallet = () => {
    // Get my Metamask address
    web3.eth.requestAccounts()
        .then((accounts) => {
            console.log("My account is ", accounts[0]);
            account.innerHTML = `Account: ${accounts[0]}`;
            address = accounts[0];
        })
        .then(() => {
            web3.eth.getBalance(`${address}`)
                .then((amount) => {
                    amount = web3.utils.fromWei(amount)
                    balance.innerHTML = `Balance: ${amount} ETH`;
                });
        });
};

ethereum.on('accountsChanged', async (accounts) => {
    this.connectWallet();
});

btnWallet.addEventListener('click', connectWallet);