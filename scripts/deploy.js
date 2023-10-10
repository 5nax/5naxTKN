async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  const name = "5naxTKN";
  const symbol = "5TKN";
  const decimals = 18;

  const Token = await ethers.getContractFactory("SSnaxtkn");
  const token = await Token.deploy(name, symbol, decimals);

  console.log("Token deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
