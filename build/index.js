"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const web3_1 = __importDefault(require("web3"));
const deploy_1 = require("./deploy");
const listen_1 = require("./listen");
const load_1 = require("./load");
const send_1 = require("./send");
let fs = require('fs');
function initializeProvider() {
    try {
        let provider_data = fs.readFileSync('eth_providers/providers.json');
        let provider_json = JSON.parse(provider_data);
        let provider_link = provider_json["provider_link"];
        return new web3_1.default.providers.WebsocketProvider(provider_link);
    }
    catch (error) {
        throw "Cannot read provider";
    }
}
function getAccount(web3, name) {
    try {
        let account_data = fs.readFileSync('eth_accounts/accounts.json');
        let account_json = JSON.parse(account_data);
        let account_pri_key = account_json[name]["pri_key"];
        return web3.eth.accounts.wallet.add('0x' + account_pri_key);
    }
    catch (error) {
        throw "Cannot read account";
    }
}
var shellArgs = process.argv.slice(2);
if (shellArgs.length < 1) {
    console.error("node programName cmd, e.g. node index.js deploy");
    process.exit(1);
}
(function run() {
    return __awaiter(this, void 0, void 0, function* () {
        let web3Provider;
        let web3;
        try {
            web3Provider = initializeProvider();
            web3 = new web3_1.default(web3Provider);
        }
        catch (e) {
            throw "web3 cannot be initialized";
        }
        var cmd0 = shellArgs[0];
        if (cmd0 == "deploy") {
            let account = getAccount(web3, "trusted_server");
            let loadedoracle = (0, load_1.loadCompiledSols)(["oracle"]);
            console.log(account, shellArgs);
            let contract = yield (0, deploy_1.deployContract)(web3, account, loadedoracle.contracts["oracle"]["BookOracle"].abi, loadedoracle.contracts["oracle"]["BookOracle"].evm.bytecode.object, [account.address]);
            console.log("oracle contract address: " + contract.options.address);
            console.log(shellArgs);
            let oracleAddr = contract.options.address;
            let loaded = (0, load_1.loadCompiledSols)(["oracle", "userapp"]);
            let contractapp = yield (0, deploy_1.deployContract)(web3, account, loaded.contracts["userapp"]["UserApp"].abi, loaded.contracts["userapp"]["UserApp"].evm.bytecode.object, [oracleAddr]);
            console.log("user app contract address: " + contractapp.options.address);
            web3Provider.disconnect(1000, 'Normal Closure');
        }
        else if (cmd0 == "listen") {
            let account;
            let contract;
            try {
                let account = getAccount(web3, "trusted_server");
                let loadedoracle = (0, load_1.loadCompiledSols)(["oracle"]);
                let contractdeploy = yield (0, deploy_1.deployContract)(web3, account, loadedoracle.contracts["oracle"]["BookOracle"].abi, loadedoracle.contracts["oracle"]["BookOracle"].evm.bytecode.object, [account.address]);
                console.log("oracle contract address: " + contractdeploy.options.address);
                let oracleAddr = contractdeploy.options.address;
                let loaded = (0, load_1.loadCompiledSols)(["oracle"]);
                let contractAddr = oracleAddr;
                contract = new web3.eth.Contract(loaded.contracts["oracle"]["BookOracle"].abi, contractAddr, {});
            }
            catch (err) {
                console.error("error listening oracle contract");
                console.error(err);
            }
            (0, listen_1.handleRequestEvent)(contract, (caller, requestId, data) => __awaiter(this, void 0, void 0, function* () {
                let reqs = web3.eth.abi.decodeParameters(['string', 'string'], data);
                let req1 = reqs[0];
                let req2 = reqs[1];
                // let info1 = await grabBook(req1);
                // let info2 = await grabBook(req2);
                let info1 = 'reqa';
                let info2 = 'reqb';
                let infoHex1;
                let infoHex2;
                try {
                    infoHex1 = web3.utils.toHex(info1);
                    infoHex2 = web3.utils.toHex(info2);
                }
                catch (e) {
                    console.error("invalid info grabbed");
                    console.error(e);
                    return;
                }
                let infosHex = web3.eth.abi.encodeParameters(['string', 'string'], [infoHex1, infoHex2]);
                console.log("the info in " + req1 + " is " + info1);
                console.log("the info in " + req2 + " is " + info2);
                try {
                    console.log(infosHex);
                    let receipt = yield (0, send_1.methodSend)(web3, account, contract.options.jsonInterface, "replyData(uint256,address,bytes)", contract.options.address, [requestId, caller, infosHex]);
                }
                catch (err) {
                    console.log(err);
                }
            }));
        }
    });
})();
