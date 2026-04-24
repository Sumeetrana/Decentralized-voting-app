import { ethers } from "ethers";
import abi from "../constant/abi.json";

export const getWeb3State = async () => {
  try {
    if (!(window as any).ethereum) {
      throw new Error("Metamask is not installed");
    }

    const accounts = await (window as any).ethereum.request({
      method: "eth_requestAccounts",
    });

    const selectedAccount = accounts[0];

    const chainIdHex = await (window as any).ethereum.request({
      method: "eth_chainId",
    });
    const chainId = parseInt(chainIdHex, 16);

    const provider = new ethers.BrowserProvider((window as any).ethereum);
    const signer = await provider.getSigner();
    const contractAddress = "0xCCC15B5CCAF92d34f3A99c2270920D3Fcf42c290";

    const contractInstance = new ethers.Contract(contractAddress, abi, signer);

    return { contractInstance, selectedAccount, chainId };
  } catch (error) {
    console.error(error);
    throw new Error();
  }
};
