# TP_Blockchaine

## Les contrats

### Lock.sol

Ce contrat Solidity, "Lock", permet au propriétaire de retirer les fonds après une période spécifiée (_unlockTime). La fonction "withdraw" transfère les fonds au propriétaire uniquement si le temps actuel est postérieur à la période de déverrouillage et que l'appelant est le propriétaire.

Il est impossible de déployer ce contrat avec une date passée.

![Image 3](screenshot/image_3.png)

Il n'est pas possible de retirer les fonds avant la date rentrée lors du déploiement.

![Image 4](screenshot/image_4.png)

Il est impossible de retirer les fonds si l'on n'est pas le propriétaire du contrat.

![Image 5](screenshot/image_5.png)

### Secret.sol

Le contrat Solidity "Secret" permet au propriétaire de définir et de récupérer un secret. Seul le propriétaire peut voir ou modifier le secret. La fonction "setSecret" permet de mettre à jour le secret en échange de frais (100 wei), tandis que "getSecret" permet au propriétaire de le voir.

Dans la capture d'écran ci-dessous, l'accès au secret est restreint au seul propriétaire du contrat.

![Image 1](screenshot/image_1.png)

Dans la capture d'écran suivante, on observe que si le solde du propriétaire est insuffisant, la modification du secret lui est refusée.

![Image 2](screenshot/image_2.png)

# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
