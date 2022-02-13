//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by Motonari Sakuma on 2022/02/13.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm() //Realmの変数を宣言
    
    @IBOutlet var titleTextField: UITextField! //アウトレット変数の宣言
    @IBOutlet var contentTextField: UITextField! //アウトレット変数の宣言

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        
        let memo: Memo? = read() //定数memoを初期化
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
        
        if memo != nil {
            titleTextField.text = memo?.title
            contentTextField.text = memo?.content
        }
        
        if let memo = memo{
            titleTextField.text = memo.title
            contentTextField.text = memo.content
        }
        
        // Do any additional setup after loading the view.
    }
    //Realmiｎアクセス、メモの情報を読み出しているraedしている。
    func read() -> Memo? {
        return realm.objects(Memo.self).first //realを使ってデータベース中のMemoオブジェクトから最初のデータを取り出している
    }
    
    @IBAction func save(){ //保存ボタンを押した時に呼び足す
        let title: String = titleTextField.text! //textfieldの文字列を習得
        let content: String = contentTextField.text!
        
        let memo: Memo? = read() //すでに保存されているメモを取得
        
        if memo != nil{ //メモの更新、新規作成を条件分岐、nilでない時は更新処理、nilの時は新規作成を処理
            try! realm.write { //メモを更新
                memo!.title = title
                memo!.content = content
            }
        } else {
            let newMemo = Memo() //メモを新規作成
            newMemo.title = title
            newMemo.content = content
            try! realm.write {
                realm.add(newMemo)
            }
        }
        
        //アラートを表示
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました",preferredStyle: .alert) //表示するアラートを作ろう
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)) //アラート内にボタンを設定
        
        present(alert, animated: true, completion: nil) //創ったアラートを画面に表示
    }
    
    //キーボードの甘露湯ボタンが押された時にキーボードを閉じる様に設定
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

