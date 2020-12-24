const appName = "Elevated SEO";

const uploadPhoto = "Upload Photos";
const createPost = "Create / Update Posts";
const insights = "Insights";
const updateProfile = "Update GMB Profile";
const manageServiceAraa = "Manage Service Area & Business";
const locationServices = "Location Information";

List<String> convertInsigtsDataToSimple(String data) {
  switch (data) {
    case "QUERIES_DIRECT":
      return [
        'Direct Queries',
        'The number of times the resource was shown when searching for the location directly.'
      ];
      break;
    case "QUERIES_INDIRECT":
      return [
        "Indirect Queries",
        'The number of times the resource was shown as a result of a categorical search.'
      ];
      break;
    case "QUERIES_CHAIN":
      return [
        "Chain Queries",
        "The number of times a resource was shown as a result of a search for the chain it belongs to, or a brand it sells."
      ];
      break;
    case "VIEWS_MAPS":
      return [
        "Map Views",
        "The number of times the resource was viewed on Google Maps."
      ];
      break;
    case "VIEWS_SEARCH":
      return [
        "Search Views",
        "The number of times the resource was viewed on Google Search."
      ];
      break;
    case "ACTIONS_WEBSITE":
      return ["Webiste Visits", "The number of times the website was clicked."];
      break;
    case "ACTIONS_PHONE":
      return [
        "Phone Rings",
        "The number of times the phone number was clicked."
      ];
      break;
    case "ACTIONS_DRIVING_DIRECTIONS":
      return [
        "Directions Clicked",
        "The number of times driving directions were requested."
      ];
      break;
    case "PHOTOS_VIEWS_MERCHANT":
      return [
        "Views on Medias",
        "The number of views on media items uploaded by the merchant."
      ];
      break;
    case "PHOTOS_VIEWS_CUSTOMERS":
      return [
        "Views on Medias (Customers)",
        "The number of views on media items uploaded by customers."
      ];
      break;
    case "PHOTOS_COUNT_MERCHANT":
      return [
        "Media Items",
        "	The total number of media items that are currently live that have been uploaded by the merchant."
      ];
      break;
    case "PHOTOS_COUNT_CUSTOMERS":
      return [
        "Media items by Customers",
        "The total number of media items that are currently live that have been uploaded by customers."
      ];
      break;

    case "LOCAL_POST_VIEWS_SEARCH":
      return [
        "Views on Local Posts",
        "The number of times the local post was viewed on Google Search."
      ];
      break;
    case "LOCAL_POST_ACTIONS_CALL_TO_ACTION":
      return [
        "Call to Action",
        "The number of times the call to action button was clicked on Google."
      ];
      break;

    default:
      return ["A", "B"];
  }
}
