let btnWallet = document.getElementById('btn-wallet');
let account = document.getElementById('account');

// if Metamask is not available
if (typeof window.ethereum == 'undefined') {
    alert("You should install Metamask to use it!");
}

// Web3 instance
let web3 = new Web3(window.ethereum);

btnWallet.addEventListener('click', () => {
    // Get my Metamask address
    web3.eth.requestAccounts().then((accounts) => {
        console.log("My account is ", accounts[0]);
        account.innerHTML = `Account: ${accounts[0]}`;
    });
});