// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract ERC721 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);    

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovals;

    // return the number of the user
    function balanceOf(address owner) external view returns (uint256) {
        uint256 balance = _balances[owner];
        require(owner != address(0), "Address is the zero");
        return balance;
    }

    // find the owner of the NFT
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token ID does not exist");
        return _owners[tokenId];
    }

    // enable || disable an operator
    function setApprovalForAll(address operator, bool approved) external {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);    
    }

    // check if an address is an operator for another address
    function isApprovalForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    // update an approved address for an NFT
    function approve(address to, uint256 tokenId) public payable {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovalForAll(owner, msg.sender), "msg.sender is not the owner or the approved operator");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // Gets the approved address for an NFT
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID does not exist"); 
        return _tokenApprovals[tokenId];
    }

    // Transfer ownership of a single NFT
    function transferFrom(address from, address to, uint256 tokenId) public payable {
        address owner = ownerOf(tokenId);

        require(
            msg.sender == owner ||
            getApproved(tokenId) ==  msg.sender ||
            isApprovalForAll(owner, msg.sender),
            "Msg.sender is not the owner or approved" 
        );

        require(owner == from, "from address is not the owner");
        require(to != address(0), "Address is the zero address");
        require(_owners[tokenId] != address(0), "Token ID does not exist");
         
        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

//bytes memory _data
    // standard transferFrom method
    // checks if the receiver smart contract is capable of receiving NFTs 
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public payable {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    }

    // simple version to check the ability of the receiver ==> true || false
    function _checkOnERC721Received() private pure returns (bool) {
        return true;
    }

    // 
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable {
        safeTransferFrom(from, to, tokenId, "");
    }

    // EIP165 proposal: query if a contract implement another interface
    function supportsInterface(bytes4 interfaceID) public pure virtual returns (bool) {
        return interfaceID == 0x80ac58cd;
    }
}