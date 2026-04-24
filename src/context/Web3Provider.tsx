import { useState } from "react";
import { Web3Context, type Web3ContextType } from "./Web3Context";
import { getWeb3State } from "../utils/getWeb3State";

export const Web3Provider = ({ children }: { children: React.ReactNode }) => {
  const [web3State, setWeb3State] = useState<Web3ContextType["web3State"]>({
    contractInstance: null,
    selectedAccount: null,
    chainId: null,
  });

  const handleWallet = async () => {
    const { contractInstance, selectedAccount, chainId } = await getWeb3State();
    setWeb3State({ contractInstance, selectedAccount, chainId });
  };

  return (
    <>
      <Web3Context.Provider value={{ web3State, setWeb3State }}>
        {children}
      </Web3Context.Provider>
      <button onClick={handleWallet}>Connect Wallet</button>
    </>
  );
};
