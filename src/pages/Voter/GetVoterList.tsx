import React from "react";
import { useWeb3Context } from "../../context/useWeb3Context";

function GetVoterList() {
  const web3Context = useWeb3Context();
  const { contractInstance } = web3Context!.web3State;

  React.useEffect(() => {
    const fetchVoterList = async () => {
      try {
        const voterList = await contractInstance.getVoterList();
        console.log(voterList);
      } catch (error) {
        console.error(error);
      }
      contractInstance && fetchVoterList();
    };
  }, [contractInstance]);

  return <></>;
}

export default GetVoterList;
