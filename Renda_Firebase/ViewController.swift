//
//  ViewController.swift
//  Renda_Firebase
//
//  Created by Yuki Hirayama on 2022/08/28.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    // タップ数を表示するLabelの変数を準備する
    @IBOutlet var countLabel: UILabel!
    // TAPボタンの変数を準備する
    @IBOutlet var tapButton: UIButton!
    // タップを数える変数を準備する
    var tapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // ボタンを丸くする
        tapButton.layer.cornerRadius = 125

        // ここから下を追加
        // Firestoreのデータを監視する
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
            if error != nil {
                print("エラーが発生しました")
                print(error)
                return
            }
            let data = snapshot?.data()
            if data == nil {
                print("データがありません")
                return
            }
            let count = data!["count"] as? Int
            if count == nil {
                print("countという対応する値がありません")
                return
            }
            self.tapCount = count!
            self.countLabel.text = String(count!)
        }
    }
    
    
    // Firestoreを扱うためのプロパティ
    let firestore = Firestore.firestore()

    // TAPボタンがタップされたときに
    @IBAction func tapTapButton() {
        // タップを数える変数にプラス1する
        tapCount += 1
        // タップされた数をLabelに反映する
        countLabel.text = String(tapCount)
        // FirestoreにtapCountを書き込む
        firestore.collection("counts").document("share").setData(["count": tapCount])
    }
    
    
    


}

