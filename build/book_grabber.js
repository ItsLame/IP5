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
Object.defineProperty(exports, "__esModule", { value: true });
exports.grabBook = void 0;
function grabBook(book) {
    return __awaiter(this, void 0, void 0, function* () {
        const axios = require('axios').default;
        return axios.get(`https://ip.jsontest.com/${book}`)
            .then(function (response) {
            var _a, _b;
            return __awaiter(this, void 0, void 0, function* () {
                return (_b = (_a = response === null || response === void 0 ? void 0 : response.data) === null || _a === void 0 ? void 0 : _a.book) === null || _b === void 0 ? void 0 : _b.replace(/[^0-9-\.]/g, '');
            });
        })
            .catch(function (error) {
            console.log(error);
        });
    });
}
exports.grabBook = grabBook;
