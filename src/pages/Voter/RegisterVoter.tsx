import React from "react";
import { useWeb3Context } from "../../context/useWeb3Context";

function RegisterVoter() {
  const web3Context = useWeb3Context();
  const { contractInstance } = web3Context!.web3State;

  const [voterDetails, setVoterDetails] = React.useState({
    name: "",
    age: "",
    gender: "",
  });

  const handleVoterRegistration = async (e: any) => {
    try {
      e.preventDefault();
      const { name, age, gender } = voterDetails;

      await contractInstance.registerVoter(name, age, gender);
      console.log("Registration is successful");
    } catch (error) {}
  };

  return (
    <div>
      <form action="" onSubmit={handleVoterRegistration}>
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

        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default RegisterVoter;
