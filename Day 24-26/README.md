# Project 4

April 2<sup>nd</sup> 2021

## [Project 4, Part One](https://www.hackingwithswift.com/100/24)

* [Setting up](https://www.hackingwithswift.com/read/4/1/setting-up)
* [Creating a simple browser with WKWebView](https://www.hackingwithswift.com/read/4/2/creating-a-simple-browser-with-wkwebview)
* [Choosing a website: UIAlertController action sheets](https://www.hackingwithswift.com/read/4/3/choosing-a-website-uialertcontroller-action-sheets)

You should structure your methods in an organized way, and because **loadView()** gets called before **viewDidLoad()** it makes sense to position the code above it too.

We're setting the web view's **navigationDelegate** property to **self**, which means "when any web page navigation happens, please tell me – the current **view controller**.”

When we say class A: B we’re defining a new class called A that builds on the functionality provided by class B. However, when we say class A: B, C we’re saying it inherits from UIViewController (the first item in the list), and promises it implements the WKNavigationDelegate protocol.

The order here really is important: the parent class (superclass) comes first, then all protocols implemented come next, all separated by commas.

## [Project 4, Part Two](https://www.hackingwithswift.com/100/25)

* [Monitoring page loads: UIToolbar and UIProgressView](https://www.hackingwithswift.com/read/4/4/monitoring-page-loads-uitoolbar-and-uiprogressview)
* [Refactoring for the win](https://www.hackingwithswift.com/read/4/5/refactoring-for-the-win)

**UIToolbar** holds and shows a collection of **UIBarButtonItem** objects that the user can tap on. All view controllers automatically come with a toolbarItems array that automatically gets read in when the view controller is active inside a UINavigationController. All we need to do is set the array, then tell our navigation controller to show its toolbar, and it will do the rest of the work for us.

**UIProgressView** is a colored bar that shows how far a task is through its work, sometimes called a "progress bar."

Adding a UIProgressView to our toolbar requires two new pieces of information:

* You can't just add random UIView subclasses to a UIToolbar, or to the rightBarButtonItem property. Instead, you need to wrap them in a special UIBarButtonItem, and use that instead.
* Although WKWebView tells us how much of the page has loaded using its estimatedProgress property, the WKNavigationDelegate system doesn't tell us when this value has changed. So, we're going to ask iOS to tell us using a powerful technique called key-value observing, or KVO.

UIProgressView will show thin gray line for our progress view – that's because it's default value is 0, so there's nothing colored in. Ideally we want to set this to match our webView's **estimatedProgress** value, which is a number from 0 to 1, but WKNavigationDelegate doesn't tell us when this value has changed.

Apple's solution to this called **key-value observing (KVO)**, and it effectively lets you say, "please tell me when the property X of object Y gets changed by anyone at any time."

We're going to use KVO to watch the estimatedProgress property, and I hope you'll agree that it's useful. First, we add ourselves as an observer of the property on the web view by adding this to viewDidLoad():

~~~
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
~~~

The **addObserver()** method takes four parameters: who the observer is (we're the observer, so we use self), what property we want to observe (we want the estimatedProgress property of WKWebView), which value we want (we want the value that was just set, so we want the new one), and a context value.

**forKeyPath** and **context** bear a little more explanation. forKeyPath isn't named forProperty because it's not just about entering a property name. You can actually specify a path: one property inside another, inside another, and so on. More advanced key paths can even add functionality, such as averaging all elements in an array! Swift has a special keyword, #keyPath, which works like the #selector keyword you saw previously: it allows the compiler to check that your code is correct – that the WKWebView class actually has an estimatedProgress property.

**context** is easier: if you provide a unique value, that same context value gets sent back to you when you get your notification that the value has changed. This allows you to check the context to make sure it was your observer that was called. There are some corner cases where specifying (and checking) a context is required to avoid bugs, but you won't reach them during any of this series.

>NOTE 
>>In more complex applications, all calls to addObserver() should be matched with a call to removeObserver() when you're finished observing – for example, when you're done with the view controller.

Once you have registered as an observer using KVO, you must implement a method called observeValue(). This tells you when an observed value has changed, so add this method now:

~~~
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}
~~~

>NOTE
>>EstimatedProgress is a Double, which as you should remember is one way of representing decimal numbers like 0.5 or 0.55555. Unhelpfully, UIProgressView's progress property is a Float, which is another (lower-precision) way of representing decimal numbers. Swift doesn't let you put a Double into a Float, so we need to create a new Float from the Double.

We let users select from a list of websites, but once they are on that website they can get pretty much anywhere else they want just by following links. Wouldn't it be nice if we could check every link that was followed so that we can make sure it's on our safe list?

If you find space for a new method and start typing "web" you'll see the list of WKWebView-related code completion options. Look for the one called **decidePolicyFor** and let Xcode fill in the method for you.

This delegate callback allows us to decide whether we want to allow navigation to happen or not every time something happens. We can check which part of the page started the navigation, we can see whether it was triggered by a link being clicked or a form being submitted, or, in our case, we can check the URL to see whether we like it.

~~~
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }

    decisionHandler(.cancel)
}
~~~

## [Project 4, Part Three](https://www.hackingwithswift.com/100/26)

* [Wrap up](https://www.hackingwithswift.com/read/4/6/wrap-up)
* [Review for Project 4: Easy Browser](https://www.hackingwithswift.com/review/hws/project-4-easy-browser)