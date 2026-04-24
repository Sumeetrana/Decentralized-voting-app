import { useEffect, useState } from "react";
import { Web3Context, type Web3ContextType } from "./Web3Context";
import { getWeb3State } from "../utils/getWeb3State";
import { handleAccountChange } from "../utils/handleAccountChange";
import { handleChainChange } from "../utils/handleChainChange";

export const Web3Provider = ({ children }: { children: React.ReactNode }) => {
  const [web3State, setWeb3State] = useState<Web3ContextType["web3State"]>({
    contractInstance: null,
    selectedAccount: null,
    chainId: null,
  });

  const handleWallet = async () => {
    try {
      const { contractInstance, selectedAccount, chainId } =
        await getWeb3State();

      console.log(contractInstance, selectedAccount, chainId);

      setWeb3State({ contractInstance, selectedAccount, chainId });
    } catch (error) {
      console.log("Error: ", error);
    }
  };

  useEffect(() => {
    (window as any).ethereum.on("accountsChanges", () => {
      handleAccountChange(setWeb3State);
    });

    (window as any).ethereum.on("chainChanged", () => {
      handleChainChange(setWeb3State);
    });
  }, []);

  return (
    <>
      <Web3Context.Provider value={{ web3State, setWeb3State }}>
        {children}
      </Web3Context.Provider>
      <button onClick={handleWallet}>Connect Wallet</button>
    </>
  );
};
