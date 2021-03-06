//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `empty-box.json`.
    static let emptyBoxJson = Rswift.FileResource(bundle: R.hostingBundle, name: "empty-box", pathExtension: "json")
    /// Resource file `movie-loading.json`.
    static let movieLoadingJson = Rswift.FileResource(bundle: R.hostingBundle, name: "movie-loading", pathExtension: "json")
    
    /// `bundle.url(forResource: "empty-box", withExtension: "json")`
    static func emptyBoxJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.emptyBoxJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "movie-loading", withExtension: "json")`
    static func movieLoadingJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.movieLoadingJson
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `placeholderImage`.
    static let placeholderImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "placeholderImage")
    
    /// `UIImage(named: "placeholderImage", bundle: ..., traitCollection: ...)`
    static func placeholderImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.placeholderImage, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `FeedViewController`.
    static let feedViewController = _R.nib._FeedViewController()
    /// Nib `MovieDetailsViewController`.
    static let movieDetailsViewController = _R.nib._MovieDetailsViewController()
    /// Nib `MovieTableViewCell`.
    static let movieTableViewCell = _R.nib._MovieTableViewCell()
    
    /// `UINib(name: "FeedViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.feedViewController) instead")
    static func feedViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.feedViewController)
    }
    
    /// `UINib(name: "MovieDetailsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.movieDetailsViewController) instead")
    static func movieDetailsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.movieDetailsViewController)
    }
    
    /// `UINib(name: "MovieTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.movieTableViewCell) instead")
    static func movieTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.movieTableViewCell)
    }
    
    static func feedViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.feedViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func movieDetailsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.movieDetailsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func movieTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieTableViewCell? {
      return R.nib.movieTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieTableViewCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `MovieTableViewCell`.
    static let movieTableViewCell: Rswift.ReuseIdentifier<MovieTableViewCell> = Rswift.ReuseIdentifier(identifier: "MovieTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _FeedViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "FeedViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _MovieDetailsViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "MovieDetailsViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _MovieTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = MovieTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "MovieTableViewCell"
      let name = "MovieTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> MovieTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? MovieTableViewCell
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
