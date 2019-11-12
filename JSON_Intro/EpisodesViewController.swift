//
//  ViewController.swift
//  JSON_Intro
//
//  Created by Ahad Islam on 11/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var episodesTableView: UITableView!
    
    // MARK: - Internal Properties
    
    var episodes = [GOTEpisode]() {
        didSet {
            episodesTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    private func loadData() {
        guard let pathToData = Bundle.main.path(forResource: "episodes", ofType: "json") else {
            fatalError("episodes.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            let episodesFromJSON = try GOTEpisode.getEpisodes(from: data)
            episodes = episodesFromJSON
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}

extension EpisodesViewController: UITableViewDelegate {}

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = "Runtime: \(episode.runtime)"
        return cell
    }
}

