export const APP_ADDRESS = "0x1F79a780486957dfB9d9E78147F5d067c11Fc1dc";
export const BOOKFACTORY_ADDRESS = "0xC358b859460394E8A210A0Ee78c462f5B623aD0D";
export const BOOKFACTORY_ABI = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "books",
    outputs: [
      {
        internalType: "contract Book",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "booksReadOnly",
    outputs: [
      {
        internalType: "contract BookReadOnly",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "number",
        type: "uint256",
      },
    ],
    name: "getBook",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_bookTitle",
        type: "string",
      },
      {
        internalType: "string",
        name: "_bookAuthor",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_bookPrice",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "_sender",
        type: "address",
      },
    ],
    name: "newBook",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_bookTitle",
        type: "string",
      },
      {
        internalType: "string",
        name: "_bookAuthor",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_bookPrice",
        type: "uint256",
      },
    ],
    name: "newBookEther",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_bookTitle",
        type: "string",
      },
      {
        internalType: "string",
        name: "_bookAuthor",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_bookPrice",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "_sender",
        type: "address",
      },
    ],
    name: "newBookReadOnly",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "numBooks",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "numBooksReadOnly",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];
export const APP_ABI = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_bookAddress",
        type: "address",
      },
    ],
    name: "buyBook",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_bookAddress",
        type: "address",
      },
    ],
    name: "offMarket",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_bookTitle",
        type: "string",
      },
      {
        internalType: "string",
        name: "_bookAuthor",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_bookPrice",
        type: "uint256",
      },
    ],
    name: "publishBook",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_bookAddress",
        type: "address",
      },
    ],
    name: "sellBook",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_bookfactoryAddress",
        type: "address",
      },
      {
        internalType: "address",
        name: "_transferContractAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "bookFactory",
    outputs: [
      {
        internalType: "contract BookFactory",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "numString",
        type: "string",
      },
    ],
    name: "str2int",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [],
    name: "transferC",
    outputs: [
      {
        internalType: "contract Transfer",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];
