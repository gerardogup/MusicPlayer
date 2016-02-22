//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Gerardo Guerra Pulido on 21/02/16.
//  Copyright © 2016 Gerardo Guerra Pulido. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pvCanciones: UIPickerView!
    @IBOutlet weak var imgPortada: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    
    private var reproductor:AVAudioPlayer!
    var data = Canciones.listaDeCanciones
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pvCanciones.dataSource = self
        self.pvCanciones.delegate = self
        cargarCancion(0)
    }
    
    func cargarCancion(cancionIndex: Int){
        let SonidoURL = NSBundle.mainBundle().URLForResource(Canciones.listaDeCanciones[cancionIndex], withExtension: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: SonidoURL!)
            imgPortada.image = UIImage(named: Canciones.listaDePortadas[cancionIndex])
            lblTitulo.text = Canciones.listaDeCanciones[cancionIndex]
        } catch {
            print("Error al cargar el archivo de sonido")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tocar() {
        if !reproductor.playing {
            reproductor.play()
        }
    }

    @IBAction func pausar() {
        if reproductor.playing {
            reproductor.pause()
        }
    }
    
    @IBAction func detener() {
        if reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    @IBAction func aleatorio() {
        let index: Int = Int(arc4random_uniform(UInt32(data.count)))
        cargarCancion(index)
        pvCanciones.selectRow(index, inComponent: 0, animated: true)
        tocar()
    }
    
    @IBAction func volumen(sender: UISlider) {
        reproductor.volume = sender.value
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        // Column count: use one column.
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            
            // Row count: rows equals array length.
            return data.count
    }
    
    func pickerView(pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String? {
            
            // Return a string from the array for this row.
            return data[row]
    }
    
    func pickerView(
        pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        cargarCancion(pvCanciones.selectedRowInComponent(0))
        tocar()
    }
}

