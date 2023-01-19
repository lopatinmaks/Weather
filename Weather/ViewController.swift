import UIKit

final class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private var myScrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        myScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        myScrollView.contentInset = contentInsets
        myScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        myScrollView.contentInset = UIEdgeInsets.zero
        myScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        myScrollView.endEditing(true)
    }
    
    private func checkLoginInfo() -> Bool {
        guard let loginText = loginTextField.text else { return false }
        guard let passwordText = passwordTextField.text else { return false }
        
        if loginText == "admin", passwordText == "12345" {
            print("Успешно!")
            return true
        } else {
            print("Попробуй еще раз!")
            return false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifire: String, sender: Any?) -> Bool {
        if identifire == "loginSegue" {
            if checkLoginInfo() {
                return true
            } else {
                showLoginError()
                return false
            }
        }
        return true
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Логин и/или пароль не верны", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "helloVC") as? HelloWorldViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func login(_ sender: UIButton) {
        
    }
    
    
}
