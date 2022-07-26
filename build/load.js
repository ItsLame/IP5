"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loadCompiledSols = void 0;
let fs = require('fs');
let solc = require('solc');
function findImports(importPath) {
    try {
        return {
            contents: fs.readFileSync(`contracts/${importPath}`, 'utf8')
        };
    }
    catch (e) {
        return {
        // error: e.message
        };
    }
}
function loadCompiledSols(solNames) {
    ;
    let sources = {};
    solNames.forEach((value, index, array) => {
        let a_file = fs.readFileSync(`contracts/${value}.sol`, 'utf8');
        sources[value] = {
            content: a_file
        };
    });
    let input = {
        language: 'Solidity',
        sources: sources,
        settings: {
            outputSelection: {
                '*': {
                    '*': ['*']
                }
            }
        }
    };
    let compiler_output = solc.compile(JSON.stringify(input), { import: findImports });
    let output = JSON.parse(compiler_output);
    return output;
}
exports.loadCompiledSols = loadCompiledSols;
