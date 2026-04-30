import React from "react";
import { useWeb3Context } from "../../context/useWeb3Context";

function RegisterCandidate() {
  const web3Context = useWeb3Context();
  const { contractInstance } = web3Context!.web3State;

  const [voterDetails, setVoterDetails] = React.useState({
    name: "",
    age: "",
    gender: "",
    party: "",
  });

  const handleCandidateRegistration = async (e: any) => {
    try {
      e.preventDefault();
      const { name, age, gender, party } = voterDetails;

      await contractInstance.registerCandidate(name, party, age, gender);
      console.log("Registration is successful");
    } catch (error) {}
  };

  return (
    <div>
      <form action="" onSubmit={handleCandidateRegistration}>
        <label htmlFor="">Name:</label>
        <input
          type="text"
          name=""
          id=""
          onChange={(e) =>
            setVoterDetails({
              ...voterDetails,
              name: e.target.value.trim(),
            })
          }
        />

        <label htmlFor="">Age:</label>
        <input
          type="text"
          name=""
          id=""
          onChange={(e) =>
            setVoterDetails({
              ...voterDetails,
              age: e.target.value.trim(),
            })
          }
        />

        <label htmlFor="">Gender:</label>
        <input
          type="text"
          name=""
          id=""
          onChange={(e) =>
            setVoterDetails({
              ...voterDetails,
              gender: e.target.value.trim(),
            })
          }
        />

        <label htmlFor="">Party:</label>
        <input
          type="text"
          name=""
          id=""
          onChange={(e) =>
            setVoterDetails({
              ...voterDetails,
              party: e.target.value.trim(),
            })
          }
        />
      </form>
    </div>
  );
}

export default RegisterCandidate;
