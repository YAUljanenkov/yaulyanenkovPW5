//
//  ArticleInteractor.swift
//  yaaulyanenkovPW5
//
//  Created by Ярослав Ульяненков on 21.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ArticleBusinessLogic
{
  func getArticles(request: Article.Fetch.Request)
}

protocol ArticleDataStore
{
    
}

class ArticleInteractor: ArticleBusinessLogic, ArticleDataStore
{
  var presenter: ArticlePresentationLogic?
  var worker: ArticleWorker?
  
  
    func getArticles(request: Article.Fetch.Request)
    {
        print("enter get articles")
        worker = ArticleWorker()
        worker?.downloadArticles(request: request, completition: {response in
            if let response = response {
                for r in response.news! {
                    print(r.title ?? "none")
                }
                self.presenter?.presentArticles(response: response)
            }
        })
    }
}
