//
//  ViewController.swift
//  SolvingEquation
//
//  Created by Hoang Son on 5/13/2018.
//  Copyright © 2018 Group_iOSUTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtA: UITextField!
    @IBOutlet weak var txtB: UITextField!
    @IBOutlet weak var txtC: UITextField!
    @IBOutlet weak var txtDelta: UILabel!
    @IBOutlet weak var txtOutput: UILabel!
    @IBOutlet weak var txtX1: UILabel!
    @IBOutlet weak var txtX2: UILabel!
    
    var a:Double = 0
    var b:Double = 0
    var c:Double = 0
    
    @IBOutlet weak var outputView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtX1.isHidden = true
        txtX2.isHidden = true
        txtDelta.isHidden = true
        outputView.isHidden = true
        txtA.delegate = self
        txtB.delegate = self
        txtC.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // function check input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789-").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    //Function check character minus
    func checkCharacter(character: String) -> Bool{
        let charIndex = character[character.index(character.startIndex, offsetBy: 0)]
        if (charIndex == "-"){
            var count: Int = 0;
            for charac in character.characters{
                if (charac == "-"){
                    count+=1;
                }
            }
            if (count > 1){
                return false;
            }
            else{
                return true;
            }
        }
        else{
            var count: Int = 0;
            for charac in character.characters{
                if (charac == "-"){
                    count+=1;
                }
            }
            if (count > 0){
                return false;
            }
            else{
                return true;
            }
        }
    }

    //Function solve equation
    func solveEquation(){
        if (txtA.text! == "" || txtB.text == "" || txtC.text == ""){
            //create alert
            let alert = UIAlertController(title: "Cảnh Báo", message: "Nhập Thiếu Trường\nVui Lòng Nhập Đủ!!!", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            outputView.isHidden = true
        }
        else if(txtA.text! == "." || txtB.text == "." || txtC.text == "."){
            let alert = UIAlertController(title: "Cảnh Báo", message: "Định dạng sai\nVui Lòng Nhập Lại!!!", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            outputView.isHidden = true
        }
        else if(txtA.text! == "-" || txtB.text == "-" || txtC.text == "-"){
            let alert = UIAlertController(title: "Cảnh Báo", message: "Định dạng sai\nVui Lòng Nhập Lại!!!", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            outputView.isHidden = true
        }
        else{
            if (!checkCharacter(character: txtA.text!) || !checkCharacter(character: txtB.text!) || !checkCharacter(character: txtC.text!)){
                //create alert
                let alert = UIAlertController(title: "Cảnh Báo", message: "Định dạng sai\nVui Lòng Nhập Lại!!!", preferredStyle: UIAlertControllerStyle.alert);
                //add an action
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
                //show alert
                self.present(alert, animated: true, completion: nil);
                outputView.isHidden = true
            }
            else{
                a = Double(txtA.text!)!;
                b = Double(txtB.text!)!;
                c = Double(txtC.text!)!;
                
                if a == 0{
                    if b == 0{
                        if c == 0 {
                            txtDelta.isHidden = true
                            txtOutput.text="Phương Trình Vô Số Nghiệm"
                            txtX1.isHidden = true
                            txtX2.isHidden = true
                        }
                        else{
                            txtDelta.isHidden = true
                            txtOutput.text="Phương Trình Vô Nghiệm"
                            txtX1.isHidden = true
                            txtX2.isHidden = true
                        }
                    }
                    else{
                        txtDelta.isHidden = true
                        txtOutput.text=String(format: "Phương Trình Có 1 Nghiệm: x = %.1f", (-c/b))
                        txtX1.isHidden = true
                        txtX2.isHidden = true
                    }
                }
                else{
                    let delta: Double = b*b - 4*a*c;
                    if (delta  < 0){
                        txtDelta.isHidden = false
                        txtDelta.text = String(format: "Delta = %.1f",delta)
                        txtOutput.text = "Phương Trình Vô Nghiệm"
                    }
                    else if (delta == 0){
                        txtOutput.text = String(format: "Phương Trình Có Nghiệm Kép: x = %.1f", (-b/(2*a)))
                        txtX1.isHidden = true
                        txtX2.isHidden = true
                    }
                    else{
                        let sqrtDelta: Double = sqrt(Double(delta))
                        let x1: Double = (-b+sqrtDelta)/(2*a);
                        let x2: Double = (-b-sqrtDelta)/(2*a);
                        txtDelta.isHidden = false
                        txtOutput.text=String(format: "Phương Trình Có 2 Nghiệm:")
                        txtX1.isHidden = false
                        txtX2.isHidden = false
                        txtDelta.text = String(format: "Delta = %.1f",delta)
                        txtX1.text = String (format: "x1 = %.1f",x1)
                        txtX2.text = String (format: "x2 = %.1f",x2)
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func btnResetAction(_ sender: Any) {
        txtA.text=""
        txtB.text=""
        txtC.text=""
        outputView.isHidden = true
        txtDelta.text = ""
        txtX1.text = ""
        txtX2.text = ""
        
    }
    
    
    @IBAction func btnSolveAction(_ sender: Any) {
        outputView.isHidden = false
        solveEquation()
    }

}

