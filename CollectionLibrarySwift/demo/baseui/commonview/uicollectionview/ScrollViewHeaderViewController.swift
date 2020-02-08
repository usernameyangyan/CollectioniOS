//
//  ScrollViewHeaderViewController.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/21.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit

class ScrollViewHeaderViewController:UIViewController{
    
    var scrollView:UIScrollView!
    
    
    lazy var useTip:UILabel={
        //行间隔
        let useTip = UILabel()
        
        useTip.textColor=UIColor.orange
        
        
        let str:String=("诗篇》严格来说是由大卫、摩西、亚萨和其他不知名的人等因着神的默示受圣灵的感动而写的。这部诗集的最后形式可能是由以斯拉，尼希米，或稍后于他们的文士确定下来的。关于以斯拉的编辑工作。最早告诉我们诗篇来历的，是其中三分之二诗作篇首的题记。在希伯来原文中，这些题记是正文的一部分，虽然这些题记在七十士译本以前就有，仍有许多学者认为它们是《诗篇》结集以后加上去的，从而怀疑它们的有效性和可靠性。这些学者的理由是：1.这些题记的来历不明；2.内容有时含糊不清；3.题记的说法或言下之意似乎与某些诗篇的内容和风格难以协调。题记的可靠性而较为保守的《诗篇》学者则相信这些题记的可靠性。其理由是：1.这些题记的来历可以追溯到公元前二世纪初，因为它们在七十士译本中就有（事实上它们的来历大大早于七十士译本，因为七十士译本的译者不明白其中的许多词语）；2.它们一直作为希伯来文本的一部分流传至今；3.古代的希伯来诗歌均附有题记；4.题记为更充分地理解诗歌的意义和信息提供了有用的背景知识。本注释赞成这种看法。有八个人的姓名出现在题记中作为《诗篇》的写作人，供稿人，编辑者，音乐家和其他有关编辑，写作和颂唱人员。他们的名字是：大卫、亚萨、可拉、摩西、希幔、以探、所罗门和耶杜顿。这些人中最主要的是大卫。虽然现代有些学者否认大卫是《诗篇》的主要作者和供稿人，仍有许多理由可以证实传统的看法。大卫本身就是诗人和音乐家（撒上16：15-23；撒下23：1；摩6：5）。他具有丰富的感情和广阔的胸怀（撒下1：19-27；撒下3：33，34），大有信心，充满激情，所以他热心事奉耶和华。在他英明而仁慈的领导下，音乐在以色列繁荣起来。攻占了敌人的堡垒耶布斯，把约柜运上锡安山后，公共礼拜的重要性增加了，从而促进了圣典所用赞美诗和音乐的创作。大卫对大自然的熟悉，对律法的了解，在逆境，悲伤和试探中所获取的教训，多年与上帝的亲近，作以色列国王丰富多彩的生活，上帝向他保证将在他的宝座上兴起一位永远的王──这一切的经历使这位耶西的儿子，牧羊人出身的国王能唱出人类心灵在渴求上帝时最甜美和最忧伤的诗歌。此外，《诗篇》中到处提到或引用大卫的生活，表现大卫的人格和技艺。《诗篇》中有许多与大卫的名字联系在一起，有些内容在撒下22章和代上16：1-36中引用。这一切都有力地证明大卫的作者身份。《新约》在太22：43-45；可12：36，37；路20：42-44；徒2：25；徒4：25；罗4：6-8；罗11：9-10；来4：7中提到了大卫的名字，更证明上述主张的正确性。怀爱伦的著作也提供了充分的证词（见《先祖与先知》642-754页；《教育论》164，165页）。《诗篇》中有73篇附有题记“大卫的诗”。第一卷中有37篇，第二卷中有18篇，第三卷中1篇，第四卷中2篇，第五卷中15篇。这73篇一般称为大卫诗集。不过，单凭“大卫的诗”还不足以证明大卫是作者。根据希伯来原文，这可以指大卫所写的诗，也可以指大卫所收集的诗。但是同其他的证据结合起来看，至少可以证明其中有许多是大卫所写的。关于原文中介词“le”（的）与专有名词连用的问题，巴恩斯说：“这样的说法虽然不能表明乃至于证实所有这些诗都是大卫所写，但可以说明作者之中最杰出的就是以色列最伟大的大卫王。”有12篇诗写着题记“亚萨的诗”（诗50：73-83）。象“大卫的诗”一样，“亚萨的诗”也不能证明是亚萨所写。其中有几首很明显是大卫所写（见诗73，77，80篇序言）。亚萨是利未人，大卫圣诗班的负责人之一。象大卫一样，亚萨是一位先知和音乐家（见代上6：39；代下29：30；尼12：46）。在返回耶路撒冷的被掳者名单中，亚萨的后裔是唯一提到的歌手（拉2：41）。有11篇诗的题记写着“可拉后裔的诗”（诗42，44-49，84，85，87，88篇）。可拉因为反对摩西的权威而受到处罚，他的后裔却没有受到株连。他们在圣殿的崇拜中担任领袖（见代上6：22；代上9：19）。有一首“可拉后裔的诗”又注明是“以斯拉人希幔的训诲诗”。希幔是约珥的儿子，撒母耳的孙子，利未支派的哥辖族人，是圣殿音乐的负责人之一（代上6：33；代上15：17；代上16：41，42）。有3篇诗的题记上有耶杜顿的名字（诗39，62和77篇）。他是圣殿唱诗班的负责人。不过题记中还有其他人的名字。这三首诗可能不是耶杜顿所写，而是由他作曲配词的。有一首诗注明是“以斯拉人以探的训诲诗”（见王上4：31；诗89篇）。有两首诗注明是“所罗门的诗”（诗72，127篇）。有一首诗注明是“摩西的祈祷”（诗90篇）。诗篇中有三分之一没有题记，不知为何人所写。据推测，写这些诗的可能是旧约圣经中其他有名的人物，如以斯拉，以赛亚，耶利米，以西结，哈该等。历史背景编辑探索作者和创作年代现代学者从19世纪中期开始，根据《诗篇》的题记探索诗篇的作者和创作年代。在过去一百年时间里，学者们确定《诗篇》创作的年代跨度为一千多年，从摩西开始到亚历山大·雅尼阿斯（公元前78年），不过学者们的看法也很不一致。埃瓦尔德（英，1880）认为《诗篇》中13篇写于大卫时代，其余大部分写于被掳之后。切恩（1888,1891）认为有16篇写于被掳之前（主要是约西亚王时代），其余均作于被掳之后──30首作于马加比时代。随着这段时期圣经学者中圣经考证学的兴起，有一种普遍的倾向认为《诗篇》中只有少数是属于大卫和他的时代，大多数是被掳后的作品，主要是波斯和希腊时代，有一些明显是马加比时代。但到了本世纪初，普遍的倾向又趋于中庸，认为大部分诗篇写于波斯时期。。考古学的最新发现，特别是乌加列泥板文书的出土（1929年以来）似可证明许多诗篇是巴勒斯坦早期历史的产物（见罗利《旧约和现代研究》）。巴滕威泽（1938年）认为《诗篇》的写作日期是从约书亚时代至希腊化时期，最迟不超过公元前312年。")
        
        //开启自动换行
        useTip.numberOfLines = 0
        useTip.lineBreakMode = NSLineBreakMode.byWordWrapping
        useTip.text=str
        
        
        useTip.frame = CGRect(x: 20, y: 20, width: self.view.frame.width - 40, height: UILabelUtils.getLabHeigh(labelStr: str, font: useTip.font, width: self.view.frame.width - 40,lineSpacing: 0))
        
        
        return useTip
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor=UIColor.white
        NavigationUtils
            .with(controller: self)
            .setTitle(title: InternationalUtils.getInstance.getString("scrollview_header"))
            .setBackBarButtonItem(style: .image(UIImage(named: "back_btn")),tintColor: UIColor.gray)
            .build()
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.delegate = self
        
        //增加伸缩头部
        scrollView!.addSubview(ScaleHeaderView(frame: self.view.bounds))
        
        scrollView!.addSubview(useTip)
        
        
        scrollView!.contentSize = CGSize(width: UIScreen.main.bounds.width, height: useTip.frame.height+300+useTip.frame.origin.y)
        
        self.view.addSubview(scrollView!)
        
    }
    
}

extension ScrollViewHeaderViewController:UIScrollViewDelegate{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var delta = scrollView.contentOffset.y / CGFloat(300) + 1
        delta = CGFloat.maximum(delta, 0)
        NavigationUtils.with(controller: self).setAlpha(alpha:  CGFloat.minimum(delta, 1)).build()
    }
}
