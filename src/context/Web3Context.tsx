import { createContext } from "react";

export type Web3ContextType = {
  web3State: {
    contractInstance: any;
    selectedAccount: string | null;
    chainId: number | null;
  };
  setWeb3State: React.Dispatch<React.SetStateAction<any>>;
};

export const Web3Context = createContext<Web3ContextType | null>(null);
