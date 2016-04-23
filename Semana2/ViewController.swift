//
//  ViewController.swift
//  Semana2
//
//  Created by Miguel Benavente Valdés on 22/04/16.
//  Copyright © 2016 Miguel Benavente Valdés. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutores: UILabel!
    @IBOutlet weak var lblPortada: UILabel!
    @IBOutlet weak var lblMensaje: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lblTitulo.text = ""
        self.lblAutores.text = ""
        self.lblPortada.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func txtBuscaISBN(sender: AnyObject) {
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string:urls + self.txtISBN.text!)
        let datos = NSData(contentsOfURL:url!)
        let datos2 : NSData? = NSData(contentsOfURL:url!)
        if datos2 != nil{
            let texto = NSString(data : datos!, encoding: NSUTF8StringEncoding )
            print(datos)
            print(datos2)
            print(texto)
            if texto != "{}"{
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    let dico1 = json as! NSDictionary
                    let dico2 = dico1["ISBN:978-84-376-0494-7"] as! NSDictionary //978-84-376-0494-7
                    let dico3 = dico2["authors"]! [0] as! NSDictionary
                    
                    self.lblTitulo.text = dico2["title"] as! NSString as String
                    self.lblAutores.text = dico3["name"] as! NSString as String
                    self.lblPortada.text = "No se encontroó información"
                }
                catch _{
                    
                }
                lblMensaje.text="La conexión se realizo correctamente"
                lblMensaje.textColor=UIColor.darkGrayColor()
            }
            /*if texto != "{}"{
                lblMensaje.text="La conexión se realizo correctamente"
                lblMensaje.textColor=UIColor.darkGrayColor()
            }*/
            else{
                lblMensaje.text="No se encontró el recurso que buscas"
                lblMensaje.textColor=UIColor.orangeColor()
                lblTitulo.text = ""
                lblAutores.text = ""
                lblPortada.text = ""
            }
        }
        else{
            self.lblMensaje.textColor=UIColor.redColor()
            self.lblMensaje.text="No se realizó la conexión"
            lblTitulo.text = ""
            lblAutores.text = ""
            lblPortada.text = ""
        }
        
    }

}

