# Project 6

April 11<sup>th</sup> 2021

|                        |                        |                        |
|:----------------------:|:----------------------:|:----------------------:|
| ![](images/img_1.png)  | ![](images/img_2.png)  | ![](images/img_3.png)  |

## [Project 6, Part One](https://www.hackingwithswift.com/100/30)

* [Setting up](https://www.hackingwithswift.com/read/6/1/setting-up)
* [Advanced Auto Layout](https://www.hackingwithswift.com/read/6/2/advanced-auto-layout)
* [Auto Layout in code: addConstraints() with Visual Format Language](https://www.hackingwithswift.com/read/6/3/auto-layout-in-code-addconstraints-with-visual-format-language)

## Visual Format Language

~~~
override func viewDidLoad() {
    super.viewDidLoad()

    let label1 = UILabel()
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.backgroundColor = UIColor.red
    label1.text = "THESE"
    label1.sizeToFit()

    let label2 = UILabel()
    label2.translatesAutoresizingMaskIntoConstraints = false
    label2.backgroundColor = UIColor.cyan
    label2.text = "ARE"
    label2.sizeToFit()

    let label3 = UILabel()
    label3.translatesAutoresizingMaskIntoConstraints = false
    label3.backgroundColor = UIColor.yellow
    label3.text = "SOME"
    label3.sizeToFit()

    let label4 = UILabel()
    label4.translatesAutoresizingMaskIntoConstraints = false
    label4.backgroundColor = UIColor.green
    label4.text = "AWESOME"
    label4.sizeToFit()

    let label5 = UILabel()
    label5.translatesAutoresizingMaskIntoConstraints = false
    label5.backgroundColor = UIColor.orange
    label5.text = "LABELS"
    label5.sizeToFit()        

    view.addSubview(label1)
    view.addSubview(label2)
    view.addSubview(label3)
    view.addSubview(label4)
    view.addSubview(label5)
}
~~~

All that code creates five UILabel objects, each with unique text and a unique background color. All five views then get added to the view belonging to our view controller by using view.addSubview().

We also set the property translatesAutoresizingMaskIntoConstraints to be false on each label, because by default iOS generates Auto Layout constraints for you based on a view's size and position. We'll be doing it by hand, so we need to disable this feature.

At the moment all the labels are placed in their default position (at the top-left of the screen) and are all sized to fit their content thanks to us calling sizeToFit() on each of them.

We're going to add some constraints that say each label should start at the left edge of its superview, and end at the right edge. What’s more, we're going to do this using a technique called Auto Layout **Visual Format Language (VFL)**, which is kind of like a way of drawing the layout you want with a series of keyboard symbols.

Before we do that, we need to create a dictionary of the views we want to lay out. The reason this is needed for VFL will become clear shortly, but first here's the dictionary you need to add below the last call to addSubview():

~~~
let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
~~~

So, to get access to label1, we can now use viewsDictionary["label1"].

~~~
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
~~~

That's a lot of code, but actually it's just the same thing five times over. As a result, we could easily rewrite those in a loop, like this:

~~~
for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}
~~~

Let's eliminate the easy stuff, then focus on what remains.

* view.addConstraints(): this adds an array of constraints to our view controller's view. This array is used rather than a single constraint because VFL can generate multiple constraints at a time.
* NSLayoutConstraint.constraints(withVisualFormat:) is the Auto Layout method that converts VFL into an array of constraints. It accepts lots of parameters, but the important ones are the first and last.
* We pass [] (an empty array) for the options parameter and nil for the metrics parameter. You can use these options to customize the meaning of the VFL, but for now we don't care.

Let's look at the Visual Format Language itself: "H:|[label1]|". As you can see it's a string, and that string describes how we want the layout to look. That VFL gets converted into Auto Layout constraints, then added to the view.

"H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view." And this is where our viewsDictionary dictionary comes in: we used strings for the key and UILabels for the value, then set "label1" to be our label. 

This dictionary gets passed in along with the VFL, and gets used by iOS to look up the names from the VFL. So when it sees [label1], it looks in our dictionary for the "label1" key and uses its value to generate the Auto Layout constraints.

Now all the labels sit edge-to-edge in the view, they all overlap. 

We're going to fix this with another set of constraints, but this time it's just one (long) line.

~~~
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
~~~

This time we're specifying V:, meaning that these constraints are vertical. And we have multiple views inside the VFL, so lots of constraints will be generated. The new thing in the VFL this time is the - symbol, which means "space". It's 10 points by default, but you can customize it.

Note that our vertical VFL doesn't have a pipe at the end, so we're not forcing the last label to stretch all the way to the edge of our view. This will leave whitespace after the last label.

[Adaptivity and Layout](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)
[Auto Layout Without Constraints](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutWithoutConstraints.html#//apple_ref/doc/uid/TP40010853-CH8-SW1)
[Get safe area inset](https://stackoverflow.com/questions/46829840/get-safe-area-inset-top-and-bottom-heights/53864017)
[Detect orientation changes](https://stackoverflow.com/questions/38894031/swift-how-to-detect-orientation-changes)

## [Project 6, Part Two](https://www.hackingwithswift.com/100/31)

* [Auto Layout metrics and priorities: constraints(withVisualFormat:)](https://www.hackingwithswift.com/read/6/4/auto-layout-metrics-and-priorities-constraintswithvisualformat)
* [Auto Layout anchors](https://www.hackingwithswift.com/read/6/5/auto-layout-anchors)
* [Wrap up](https://www.hackingwithswift.com/read/6/6/wrap-up)
* [Review for Project 6: Auto Layout](https://www.hackingwithswift.com/review/hws/project-6-auto-layout)

Without a rule regarding the bottom of the last label it's possible the views might be pushed off the bottom edge.

To begin to fix this problem, we're going to add a constraint for the bottom edge saying that the bottom of our last label must be at least 10 points away from the bottom of the view controller's view. We're also going to tell Auto Layout that we want each of the five labels to be 88 points high. Replace the previous vertical constraints with this:

~~~
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
~~~

The difference here is that we now have numbers inside parentheses: (==88) for the labels, and (>=10) for the space to the bottom. Note that when specifying the size of a space, you need to use the - before and after the size: a simple space, -, becomes -(>=10)-.

We are specifying two kinds of size here: == and >=. The first means "exactly equal" and the second "greater than or equal to." So, our labels will be forced to be an exact size, and we ensure that there's some space at the bottom while also making it flexible – it will definitely be at least 10 points, but could be 100 or more depending on the situation.

you can give VFL a set of sizes with names, then use those sizes in the VFL rather than hard-coding numbers. For example, we wanted our label height to be 88, so we could create a metrics dictionary like this:

~~~
let metrics = ["labelHeight": 88]
~~~

Then, whenever we had previously written ==88, we can now just write labelHeight. So, change your current vertical constraints to be this:

~~~
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
~~~

So when your designer / manager / inner-pedant decides that 88 points is wrong and you want some other number, you can change it in one place to have everything update.

Before we're done, we're going to make one more change that makes the whole user interface much better, because right now it's still imperfect. To be more specific, we're forcing all labels to be a particular height, then adding constraints to the top and bottom. This still works fine in portrait, but in landscape you're unlikely to have enough room to satisfy all the constraints.

With our current configuration, you'll see this message when the app is rotated to landscape: "Unable to simultaneously satisfy constraints." This means your constraints simply don't work given how much screen space there is, and that's where priority comes in. You can give any layout constraint a priority, and Auto Layout will do its best to make it work.

Constraint priority is a value between 1 and 1000, where 1000 means "this is absolutely required" and anything less is optional. By default, all constraints you have are priority 1000, so Auto Layout will fail to find a solution in our current layout. But if we make the height optional – even as high as priority 999 – it means Auto Layout can find a solution to our layout: shrink the labels to make them fit.

It's important to understand that Auto Layout doesn't just discard rules it can't meet – it still does its best to meet them. So in our case, if we make our 88-point height optional, Auto Layout might make them 78 or some other number. That is, it will still do its best to make them as close to 88 as possible. TL;DR: constraints are evaluated from highest priority down to lowest, but all are taken into account.

So, we're going to make the label height have priority 999 (i.e., very important, but not required). But we're also going to make one other change, which is to tell Auto Layout that we want all the labels to have the same height. This is important, because if all of them have optional heights using labelHeight, Auto Layout might solve the layout by shrinking one label and making another 88.

From its point of view it has at least managed to make some of the labels 88, so it's probably quite pleased with itself, but it makes our user interface look uneven. So, we're going to make the first label use labelHeight at a priority of 999, then have the other labels adopt the same height as the first label. Here's the new VFL line:

~~~
"V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
~~~

It's the @999 that assigns priority to a given constraint, and using (label1) for the sizes of the other labels is what tells Auto Layout to make them the same height.

That's it: your Auto Layout configuration is complete, and the app can now be run safely in portrait and landscape.

## Auto Layout Anchors

Every UIView has a set of anchors that define its layouts rules. The most important ones are widthAnchor, heightAnchor, topAnchor, bottomAnchor, leftAnchor, rightAnchor, leadingAnchor, trailingAnchor, centerXAnchor, and centerYAnchor.

Most of those should be self-explanatory, but it’s worth clarifying the difference between leftAnchor, rightAnchor, leadingAnchor, and trailingAnchor. For me, left and leading are the same, and right and trailing are the same too. This is because my devices are set to use the English language, which is written and read left to right. However, for right-to-left languages such as Hebrew and Arabic, leading and trailing flip around so that leading is equal to right, and trailing is equal to left.

In practice, this means using leadingAnchor and trailingAnchor if you want your user interface to flip around for right to left languages, and leftAnchor and rightAnchor for things that should look the same no matter what environment.

The best bit about working with anchors is that they can be created relative to other anchors. That is you can say “this label’s width anchor is equal to the width of its container,” or “this button’s top anchor is equal to the bottom anchor of this other button.”

~~~
for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true
}
~~~

That loops over each of the five labels, setting them to have the same width as our main view, and to have a height of exactly 88 points.

We haven’t set top anchors, though, so the layout won’t look correct just yet. What we want is for the top anchor for each label to be equal to the bottom anchor of the previous label in the loop. Of course, the first time the loop goes around there is no previous label, so we can model that using optionals.

The first time the loop goes around that will be nil, but then we’ll set it to the current item in the loop so the next label can refer to it. If previous is not nil, we’ll set a topAnchor constraint.

~~~
var previous: UILabel?

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if let previous = previous {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}
~~~

That third anchor combines a different anchor with a constant value to get spacing between the views – these things are really flexible.

Anchors also let us control the safe area nicely. The “safe area” is the space that’s actually visible inside the insets of the iPhone X and other such devices – with their rounded corners, notch and similar. It’s a space that excludes those areas, so labels no longer run underneath the notch or rounded corners.

We can fix that using constraints. In our current code we’re saying “if we have a previous label, make the top anchor of this label equal to the bottom anchor of the previous label plus 10.” But if we add an else block we can push the first label away from the top of the safe area, so it doesn’t sit under the notch, like this:

~~~
if let previous = previous {
    // we have a previous label – create a height constraint
    label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
} else {
    // this is the first label
    label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
}
~~~