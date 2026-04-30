import React from "react";
import { useWeb3Context } from "../../context/useWeb3Context";

function GetCandidateList() {
  const web3Context = useWeb3Context();
  const { contractInstance } = web3Context!.web3State;

  React.useEffect(() => {
    const fetchCandidateList = async () => {
      try {
        const candidateList = await contractInstance.getCandidateList();
        console.log(candidateList);
      } catch (error) {
        console.error(error);
      }
      contractInstance && fetchCandidateList();
    };
  }, [contractInstance]);

  return <></>;
}

export default GetCandidateList;
