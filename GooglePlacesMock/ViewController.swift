import UIKit
import GooglePlaces
import CoreLocation

//class ViewController: UIViewController {
//
//  var textField: UITextField?
//  var resultText: UITextView?
//  var fetcher: GMSAutocompleteFetcher?
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    view.backgroundColor = .white
//    edgesForExtendedLayout = []
//
//    // Set bounds to inner-west Sydney Australia.
//    let neBoundsCorner = CLLocationCoordinate2D(latitude: 38.652832,
//                                                longitude: 145.839478)
//    let swBoundsCorner = CLLocationCoordinate2D(latitude: 32.652832,
//                                                longitude: 136.839478)
//
//    // Set up the autocomplete filter.
//    let filter = GMSAutocompleteFilter()
//    filter.origin = CLLocation(latitude: 35.652832, longitude: 139.839478)
////    filter.locationBias = GMSPlaceRectangularLocationOption(neBoundsCorner, swBoundsCorner)
//    filter.locationRestriction = GMSPlaceRectangularLocationOption(neBoundsCorner, swBoundsCorner)
//
//    // Create a new session token.
//    let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken()
//
//    // Create the fetcher.
//    fetcher = GMSAutocompleteFetcher(filter: filter)
//    fetcher?.delegate = self
//    fetcher?.provide(token)
//
//    textField = UITextField(frame: CGRect(x: 5.0, y: 30.0,
//                                          width: view.bounds.size.width - 5.0,
//                                          height: 64.0))
//    textField?.autoresizingMask = .flexibleWidth
//    textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
//                         for: .editingChanged)
//    let placeholder = NSAttributedString(string: "Type a query...")
//
//    textField?.attributedPlaceholder = placeholder
//
//    resultText = UITextView(frame: CGRect(x: 0, y: 95.0,
//                                          width: view.bounds.size.width,
//                                          height: view.bounds.size.height - 65.0))
//    resultText?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//    resultText?.text = "No Results"
//    resultText?.isEditable = false
//
//    self.view.addSubview(textField!)
//    self.view.addSubview(resultText!)
//  }
//
//  @objc func textFieldDidChange(textField: UITextField) {
//    fetcher?.sourceTextHasChanged(textField.text!)
//  }
//
//}
//
//extension ViewController: GMSAutocompleteFetcherDelegate {
//  func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//    for prediction in predictions {
//      print(prediction.attributedPrimaryText)
//      print("t...", "PlaceID:", prediction.placeID)
//      print("t...", "FullText:", prediction.attributedFullText)
//      print("t...", "PrimaryText:", prediction.attributedPrimaryText)
//      print("t...", "SecondText:", prediction.attributedSecondaryText)
//      print("t...", "Types:", prediction.types)
//      print("t...", "DistanceMeter:", prediction.distanceMeters)
//      print("t...", "")
//      print("t...", "")
//    }
//  }
//
//  func didFailAutocompleteWithError(_ error: Error) {
//    resultText?.text = error.localizedDescription
//  }
//}


class ViewController: UIViewController {
  override func viewDidLoad() {
    makeButton()
  }

  // Present the Autocomplete view controller when the button is pressed.
  @objc func autocompleteClicked(_ sender: UIButton) {
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self

    // Specify the place data types to return.
    let fields: GMSPlaceField = [.all]
    autocompleteController.placeFields = fields

    // Specify a filter.
    let filter = GMSAutocompleteFilter()
//    filter.type = .address
    autocompleteController.autocompleteFilter = filter

    // Display the autocomplete view controller.
    present(autocompleteController, animated: true, completion: nil)
  }

  // Add a button to the view.
  func makeButton() {
    let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
    btnLaunchAc.backgroundColor = .blue
    btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
    btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
    self.view.addSubview(btnLaunchAc)
  }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("place.name", place.name)
    print("place.placeID", place.placeID)
    print("place.attributions", place.attributions)
    print("place.phoneNumber", place.phoneNumber)
    print("place.formattedAddress", place.formattedAddress)
    print("place.rating", place.rating)
    print("place.priceLevel", place.priceLevel)
    print("place.types", place.types)
    print("place.website", place.website)
    print("place.attributions", place.attributions)
    print("place.viewportInfo", place.viewportInfo)
    print("place.addressComponents", place.addressComponents)
    print("place.plusCode", place.plusCode)
    print("place.openingHours", place.openingHours)
    print("place.userRatingsTotal", place.userRatingsTotal)
    print("place.photos", place.photos)
    print("place.utcOffsetMinutes", place.utcOffsetMinutes)
    print("place.isOpenAtDate", place.isOpen(at: Date()))
    print("place.isOpen", place.isOpen())
    print("place.iconImageURL", place.iconImageURL)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
