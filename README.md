# VPC関連リソースのTerraform

## ディレクトリ構成
```
.
├── README.md
├── envs
│   └── dev
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── module
    └── network
        ├── locals.tf
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

## 構築方法
1. 初期化 & モジュール読み込み
```
terraform init
```

2. リソース作成
```
terraform apply
```

3. リソース削除
```
terraform destroy
```
