# Top 25 Films
A test application for a Junior iOS developer vacancy. It uses  RSS iTunes Generator to get top 25 films from iTunes Store. Then it send a request to iTunes Search API with specified film ID to get more information about film like a plot e.t.c. As iTunes API gives only 100x100 image resolution, the app has to convert it to 500x500 on Detail View Controller.

Also It must have done only programmatically without storyboard.

When app is getting a network response, it shows an activity indicator and hides tableViews.

Using libraries:
1) Alamofire to work with network.
2) Kingfisher to work with images.

To parse JSON data it uses Decode protocol.

This app was developed with using ~~clean~~ (because of some modifications for studying purposes) MVP architecture and Router to send data.

To try this app need:
1) clone repo.
2) pod install.

Here are some app's pictures.

![alt text](https://sun9-9.userapi.com/c857416/v857416292/cfbb5/zXNHbUgvqqs.jpg "Images")




