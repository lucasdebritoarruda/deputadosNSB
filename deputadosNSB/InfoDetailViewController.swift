//
//  InfoDetailViewController.swift
//  deputadosNSB
//
//  Created by Lucas de Brito on 31/08/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    // MARK: - Properties
    var infoText: UITextView!
    var index:Int?
    var contentArray = [
        
        "Na esfera federal, o Poder Legislativo brasileiro é constituído pelo Congresso Nacional, que se divide em duas casas: o Senado e a Câmara dos Deputados. O deputado federal é um representante eleito pelo povo para ocupar a Câmara, e tem como principais atribuições legislar e fiscalizar.O cargo de deputado federal é de extrema importância na política brasileira. Fonte: Politize!(http://www.politize.com.br)",
        "A principal função do deputado federal é legislar. Cabe a ele propor, discutir e aprovar leis, que podem alterar até mesmo a Constituição. É também o deputado federal quem aprova ou não as medidas provisórias, propostas pelo presidente. Outra importante responsabilidade do deputado federal é fiscalizar e controlar as ações do Poder Executivo. Para isso, conta com o suporte do Tribunal de Contas da União (TCU), órgão responsável por avaliar a aplicação dos recursos públicos. Além disso, podem solicitar informações a órgãos do governo e aos ministros, que são obrigados a prestar explicações. São os deputados federais que aprovam o Orçamento da União, uma lei editada todos os anos pelo Executivo, onde são listadas as receitas e despesas do governo federal. Quando existem denúncias ou suspeitas de irregularidade, os deputados podem criar uma Comissão Parlamentar de Inquérito (CPI), para investigar um tema ou situação específica. São eles também os únicos com poderes para autorizar a instauração de processo de impeachment contra o presidente e vice-presidente da República. Fonte: Politize!(http://www.politize.com.br)",
        "O sistema eleitoral brasileiro funciona em um modelo misto, com eleições majoritárias para o Poder Executivo e um sistema proporcional para candidatos ao legislativo. O sistema majoritário é bastante simples: vence o candidato que tiver a maioria dos votos. Já no sistema proporcional, é feito um cálculo que leva em conta alguns fatores, como o quociente eleitoral. A quantidade de deputados federais é definida pela Lei Complementar nº 78 de 1993, que estabelece um limite máximo de 513 deputados. O número de deputados federais representantes de cada estado varia entre 8 e 70, a depender do tamanho da população local. A distribuição das vagas é calculada com base em dados do Instituto Brasileiro de Geografia e Estatística (IBGE), e pode ser ajustada no ano anterior a cada eleição. Fonte: Politize!(http://www.politize.com.br)",
        "Como representante do povo na Câmara, o deputado federal é eleito para um mandato de quatro anos, não existindo limite de vezes em que ele pode ser reeleito consecutivamente. Para concorrer ao cargo, é exigido que o cidadão cumpra uma série de pré-requisitos. Confira quais são: Possuir nacionalidade brasileira; Estar em pleno exercício dos direitos políticos, ou seja, ter atingido a maioridade; ser eleitor; estar em dia com as obrigações militares (no caso dos homens); e caso tenha sofrido condenação criminal transitada em julgado, cumprir totalmente a pena; Ter domicílio eleitoral no estado em que pretende concorrer; Estar filiado a um partido político. É preciso também que o candidato tenha sido escolhido para concorrer ao cargo, em convenção partidária; Ter a idade mínima de 21 anos, a serem completados até a data oficial da posse. Fonte: Politize!(http://www.politize.com.br)",
        "Atualmente, cada deputado federal recebe um salário bruto de R$ 33.763. Além do salário, esse parlamentar tem direito ainda a um auxílio-moradia de R$ 4.253 ou a morar em um dos 432 apartamentos funcionais pertencentes à Câmara dos Deputados. O pagamento do salário mensal leva em conta o comparecimento do deputado às sessões deliberativas do Plenário e o registro nas votações realizadas. Assim, se um deputado federal não justifica ausência em uma votação, terá parte do seu salário descontado. Além disso, a ausência não justificada em ⅓ das sessões ordinárias de cada sessão legislativa pode acarretar em perda de mandato. As ausências são justificadas se o parlamentar estiver em missão oficial dentro ou fora do país, em casos de doença comprovada por atestado, licença maternidade e licença paternidade ou, ainda, falecimento de pessoa da família até o segundo grau civil e acidente. Para garantir o exercício do mandato, existem ainda outros benefícios garantidos ao deputado federal. Confira quais são: 1) Cota para o Exercício da Atividade Parlamentar (Ceap): é um valor destinado para cobrir despesas relativas ao exercício do mandato, como passagens aéreas, serviços postais, manutenção de escritórios de apoio à atividade parlamentar, hospedagem, combustível, contratação de serviços de segurança e consultoria, entre outros. A cota funciona por meio de reembolso e seu valor depende do estado de origem de cada deputado, variando entre R$ 30 mil a R$ 45 mil. 2)  Verba destinada à contratação de pessoal: é um valor de R$ 97 mil mensais, destinados à contratação de até 25 secretários parlamentares, cuja lotação pode ser no gabinete ou no estado de origem do deputado. 3) Despesas com saúde: o deputado federal tem direito ao ressarcimento integral de todas as despesas hospitalares relativas a internação em qualquer hospital do país, caso não seja possível atendimento no serviço médico da Câmara. Além disso, o deputado federal recebe também uma verba equivalente ao valor do seu salário no início e ao final do mandato, para compensar gastos devidos à mudança. Somados, o salário e os benefícios de cada deputado chegam a R$ 168,6 mil por mês. Juntos, os 513 deputados custam em média R$ 86 milhões ao mês, e a um custo anual de R$ 1 bilhão. Nem todos os benefícios dos deputados federais são de natureza monetária. Uma das vantagens do cargo é o direito ao foro privilegiado, um mecanismo que garante ao deputado o direito de ter uma ação penal contra si julgada por tribunais superiores, e não pela justiça comum. Fonte: Politize!(http://www.politize.com.br)"]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        infoText = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        infoText.text = contentArray[index!]
        infoText.font = .systemFont(ofSize:20)
        infoText.isEditable = false
        self.view.addSubview(infoText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
