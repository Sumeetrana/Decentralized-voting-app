import { useState } from "react";
import { Web3Context } from "./Web3Context";

const Web3Provider = ({ children }: { children: React.ReactNode }) => {
  const [web3State, setWeb3State] = useState({
    contractInstance: null,
    selectedAccount: null,
    chainId: null,
  });

  return (
    <>
      <Web3Context.Provider value={{ web3State, setWeb3State }}>
        {children}
      </Web3Context.Provider>
      <button>Connect Wallet</button>
    </>
  );
};
