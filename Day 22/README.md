# Project 3

March 29<sup>th</sup> 2021

## [Project 3](https://www.hackingwithswift.com/100/22)

* [About technique projects](https://www.hackingwithswift.com/read/3/1/about-technique-projects)
* [UIActivityViewController explained](https://www.hackingwithswift.com/read/3/2/uiactivityviewcontroller-explained)
* [Wrap up](https://www.hackingwithswift.com/read/3/3/wrap-up)
* [Review for Project 3: Social media](https://www.hackingwithswift.com/review/hws/project-3-social-media)

Sharing using iOS standard component called **UIActivityViewController**.

As we're working with images, UIActivityViewController will automatically give us functionality to share by iMessage, by email and by Twitter and Facebook, as well as saving the image to the photo library, assigning it to contact, printing it out via AirPrint, and more. It even hooks into AirDrop and the iOS extensions system so that other apps can read the image straight from us.

We first need to give users a way to trigger sharing, and the way we’re going to use it is to add a bar button item.

We're assigning to the **rightBarButtonItem** of our view controller's **navigationItem**. This navigation item is used by the navigation bar so that it can show relevant information. In this case, we're setting the right bar button item, which is a button that appears on the right of the navigation bar when this view controller is visible.

~~~
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
~~~

The **target** and **action** parameters go hand in hand, because combined they tell the **UIBarButtonItem** what method should be called. 

The action parameter is saying "when you're tapped, call the **shareTapped()** method," and the target parameter tells the button that the method belongs to the current view controller – self.

The part in **#selector** bears explaining a bit more, because it's new and unusual syntax. What it does is tell the Swift compiler that a method called **shareTapped** will exist, and should be triggered when the button is tapped.

~~~
@objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
        print("No image found")
        return
    }

    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
}
~~~

* We start with the method name, marked with **@objc** because this method will get called by the underlying Objective-C operating system (the UIBarButtonItem) so we need to mark it as being available to Objective-C code. When you call a method using #selector you’ll always need to use @objc too.

* Our image view may or may not have an image inside, so we’ll read it out safely and convert it to JPEG data. This has a **compressionQuality** parameter where you can specify a value between 1.0 (maximum quality) and 0.0 (minimum quality_.

* Next we create a **UIActivityViewController**, which is the iOS method of sharing content with other apps and services.

* Finally, we tell iOS where the activity **view controller** should be anchored – where it should appear from.

>NOTE
>>In case you were wondering, when you use @IBAction to make storyboards call your code, that automatically implies @objc – Swift knows that no @IBAction makes sense unless it can be called by Objective-C code.

iOS is very strict with how an app could access user storage, we need user grants permission access the user’s photo library so it can write the image there.

For this we need to edit the Info.plist file for our project.

In info.plist menu:

1. Click “Add Row” from the menu that appears, and you should see a new list of options appear that starts with “Application Category”.

2. Find the name “Privacy - Photo Library Additions Usage Description”.

3. To the right of “Privacy - Photo Library Additions Usage Description” will be an empty white space. That white space is where you can type some text to show to the user that explains what your app intends to do with their photo library.

4. Add some context of why we need user permission to access photo library: “We need to save photos you like.”

[Sharing with UIActivityVIewController](https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example)