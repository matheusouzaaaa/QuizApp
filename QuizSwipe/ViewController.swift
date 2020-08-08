//
//  ViewController.swift
//  QuizSwipe
//
//  Created by Matheus Souza on 08/08/2020.
//  Copyright © 2020 Matheus Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtPergunta: UILabel!
    
    let perguntas: [String] = ["Esse app é top?","Quiabo é bom?"]
    let gabarito: [Bool] = [true, false]
    var userAnswer: [Bool] = []
    var acertos: [Int] = []
    var posicao: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let direita = UISwipeGestureRecognizer(target: self, action: #selector(direcao(sender:)))
        direita.direction = .right
        let esquerda = UISwipeGestureRecognizer(target: self, action: #selector(direcao(sender:)))
        esquerda.direction = .left
        let acima = UISwipeGestureRecognizer(target: self, action: #selector(direcao(sender:)))
        acima.direction = .up
        let abaixo = UISwipeGestureRecognizer(target: self, action: #selector(direcao(sender:)))
        abaixo.direction = .down
        self.view.addGestureRecognizer(direita)
        self.view.addGestureRecognizer(esquerda)
        self.view.addGestureRecognizer(acima)
        self.view.addGestureRecognizer(abaixo)
        posicao = 0
        loadQuestion()
    }
    
    func loadQuestion() {
        txtPergunta.text = perguntas[posicao]
    }
    
    func answerQuestion(resposta: Bool) {
        print(posicao)
        switch posicao {
        case 0:
            if resposta {
                if gabarito[posicao] == resposta{
                    acertos.append(1)
                }
                skipQuestion(direcao: 1)
            }
            break;
        case 1:
            if resposta {
                if gabarito[posicao] == resposta{
                    acertos.append(1)
                }
                skipQuestion(direcao: 1)
            }
            break;
        default:
            break;
        }
    }
    
    func skipQuestion(direcao: Int) {
        if posicao == 0 && direcao == -1 {
            let alerta = UIAlertController(title: "Eita", message: "Responda desde o início", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(btnOk)
            present(alerta,animated: true,completion: nil)
        } else if posicao == 1 && direcao == 1 {
            let alerta = UIAlertController(title: "Acabou", message: "Você teve \(acertos.count) acertos", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(btnOk)
            present(alerta,animated: true,completion: nil)
        } else {
            posicao += direcao
        }
        loadQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func direcao(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                skipQuestion(direcao: -1)
                break;
            case .left:
                skipQuestion(direcao: 1)
                break;
            case .up:
                print("cima")
                answerQuestion(resposta: true)
                userAnswer.append(true)
                break;
            case .down:
                print("baixo")
                answerQuestion(resposta: false)
                userAnswer.append(false)
                break;
            default:
                break;
            }
        }
    }
    
}
