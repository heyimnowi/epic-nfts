pragma solidity ^0.8.1;


import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "../libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
  Counters.Counter private _tokenIds;
  event NewEpicNFTMinted(address sender, uint256 tokenId);
  string[] colors = ["red", "#08C2A8", "black", "yellow", "blue", "green"];
  string[] firstWords = ["BLAH", "BLAH", "BLAH"];
  uint NFT_LIMIT = 10;
  using Counters for Counters.Counter;

  constructor() ERC721 ("NowiNFT", "SQUARE") {
    console.log("This is my NFT contract. Woah!");
  }

  function getTotalNFTsMintedSoFar() public view returns (uint256) {
    return _tokenIds.current() + 1;
  }

  function pickQuote(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomColor(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
    rand = rand % colors.length;
    return colors[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function makeAnEpicNFT() public {
    require(getTotalNFTsMintedSoFar() < NFT_LIMIT , "Cannot emit more NFTs");

    uint256 newItemId = _tokenIds.current();
    string memory first = pickQuote(newItemId);
    string memory randomColor = pickRandomColor(newItemId);

    _setTokenURI(newItemId, "ipfs://QmfE98LYM5EyNDYTjp7XcxUmgNzYnPFphb5sds8VREFTLF");
  
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    emit NewEpicNFTMinted(msg.sender, newItemId);
  }
}