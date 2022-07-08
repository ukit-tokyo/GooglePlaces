import UIKit
import GooglePlaces
import CoreLocation

class ViewController: UIViewController {

  var textField: UITextField?
  var resultText: UITextView?
  var fetcher: GMSAutocompleteFetcher?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    edgesForExtendedLayout = []

    // Set bounds to inner-west Sydney Australia.
    let neBoundsCorner = CLLocationCoordinate2D(latitude: 38.652832,
                                                longitude: 145.839478)
    let swBoundsCorner = CLLocationCoordinate2D(latitude: 32.652832,
                                                longitude: 136.839478)

    // Set up the autocomplete filter.
    let filter = GMSAutocompleteFilter()
    filter.origin = CLLocation(latitude: 35.652832, longitude: 139.839478)
//    filter.locationBias = GMSPlaceRectangularLocationOption(neBoundsCorner, swBoundsCorner)
    filter.locationRestriction = GMSPlaceRectangularLocationOption(neBoundsCorner, swBoundsCorner)

    // Create a new session token.
    let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken()

    // Create the fetcher.
    fetcher = GMSAutocompleteFetcher(filter: filter)
    fetcher?.delegate = self
    fetcher?.provide(token)

    textField = UITextField(frame: CGRect(x: 5.0, y: 30.0,
                                          width: view.bounds.size.width - 5.0,
                                          height: 64.0))
    textField?.autoresizingMask = .flexibleWidth
    textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                         for: .editingChanged)
    let placeholder = NSAttributedString(string: "Type a query...")

    textField?.attributedPlaceholder = placeholder

    resultText = UITextView(frame: CGRect(x: 0, y: 95.0,
                                          width: view.bounds.size.width,
                                          height: view.bounds.size.height - 65.0))
    resultText?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    resultText?.text = "No Results"
    resultText?.isEditable = false

    self.view.addSubview(textField!)
    self.view.addSubview(resultText!)
  }

  @objc func textFieldDidChange(textField: UITextField) {
    fetcher?.sourceTextHasChanged(textField.text!)
  }

}

extension ViewController: GMSAutocompleteFetcherDelegate {
  func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
    for prediction in predictions {
      print("t...", "PlaceID:", prediction.placeID)
      print("t...", "FullText:", prediction.attributedFullText)
      print("t...", "PrimaryText:", prediction.attributedPrimaryText)
      print("t...", "SecondText:", prediction.attributedSecondaryText)
      print("t...", "Types:", prediction.types)
      print("t...", "DistanceMeter:", prediction.distanceMeters)
      print("t...", "")
      print("t...", "")
    }
  }

  func didFailAutocompleteWithError(_ error: Error) {
    resultText?.text = error.localizedDescription
  }
}
