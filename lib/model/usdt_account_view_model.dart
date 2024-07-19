class UsdtAccountViewModel {

  dynamic id;
  dynamic name;
  dynamic usdtWalletAddress;


  UsdtAccountViewModel(
      {this.id,
        this.name,
        this.usdtWalletAddress,
    });

  UsdtAccountViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    usdtWalletAddress = json['usdt_wallet_address'];

  }

}