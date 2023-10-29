+++
title = "Rough Guide to Matplotlib"
author = ["pspiagicw"]
date = 2021-05-17T00:00:00+05:30
tags = ["python", "programming", "machinelearning"]
categories = ["programming"]
+++

Do you have the need to create graphs? Visualize highly numerical data , or just look at beautifully generated graphs and get turned on!

**Well like any other situation Python has you covered!**

Matplotlib provides easy and efficient way of creating graphs.It is a python module , so you need `pip` to install it. `Pip` is python's modular structure allowing , us to share our code with others.

`pip` can install any module from PyPI , python's official module location , or as cool people call it repository.
To install use `pip install` command.

```sh
pip install --user matplotlib
```

Now that matplotlib is installed. We have to import it in Python , **importing** in python is easy!

```sh
import matplotlib
```

But we don't need to import matplotlib itself, `matplotlib.pyplot` provides most of the features we need. The rest of matplotlib can be used to create extremely complex graphs.
Pyplot is inspired from _MATLAB_ . If you have used _MATLAB_ before , it has the same API.
This guide only focuses on PyPlot API , for a more object-based approach , see matplotlib's documentation, or refer to this guide.


### Important Funcs {#important-funcs}

PyPlot provides some useful functions mainly `pyplot.show()` and `pyplot.savefig()`.
These provide functionality to show and save the graphs we create!.
Without these method, you can plot your graphs , but can never see them.

Plotting is when you call a particular method (More on that later!).These method configure the matplotlib backend with your graph ,
`pyplot.show()` simply shows the configured , graph.
When you try to configure more than one plot , both are shown in same frame/picture.

To see a already plotted graph , use `pyplot.show()` , but using it also clears the graph after showing.
While using it in a REPL , keep in mind to plot the graph again , before calling `pyplot.show()`.

```python
pyplot.show()

```

To save a already plotted graph , use `pyplot.savefig()` , it takes name and format of image as arguments.
For example

```python
# Graph already plotted!
pyplot.savefig('example-graph.png',format='png')
```

One thing before moving to next section!
Most people alias `pyplot` to `plt` in Python. So if you see `plt` anywhere, don't worry it is the same thing.
To alias pyplot to plt

```python
import matplotlib.pyplot as plt

```


### Basic Plotting {#basic-plotting}

For plotting basic lines , `plt.plot()` function is enough, it takes list of x and y coordinates as arguments.

Plotting points (3,2),(5,4) and (4,1).Keep in mind plot method connects all the dots with a line.

```python
x_coordinates = [ 3 , 5 , 4]
y_coordinates = [ 2 , 4 , 1]
# Points (3,2),(5,4),(4,1)
plt.plot(x_coordinates,y_coordinates)
plt.show()

```


The graph created is

{{< figure src="/images/simple-plot-matplotlib.png" caption="Figure 1: Simple Plot" >}}


### Simple Scattering {#simple-scattering}

Scatter plot simply shows all the coordinates/points without connecting them with a line.

Scatter plot are very useful in showing actual points , thus analyzing them separately.
It also takes list of x and y coordinates as arguments.

Showing (2,6),(4,5),(1,8) and (3,6) on a graph is easy.

```python
x_coordinates = [ 2 , 4 , 1 , 3 ]
y_coordinates = [ 6 , 5 , 8 , 6 ]
# Points (2,6) , (4,5) , (1,8) and (3,6)
plt.scatter(x_coordinates , y_coordinates)
plt.show()

```

The end result

{{< figure src="/images/scatter-plot-matplotlib.png" caption="Figure 2: Scattering Example" >}}


### Histograms {#histograms}

Histograms in matplotlib is as easy as just giving the list of values you want a histogram of.Matplotlib automatically calculates the rest!

```python
plt.hist([ random.randint(5,100) for _ in range(300) ])

```

{{< figure src="/images/simple-hist-matplotlib.png" caption="Figure 3: Simple Histogram" >}}

It provides a good view of how the data is distributed.


### Showing Images. {#showing-images-dot}

One more useful function , I use most of the time is `plt.imshow()` . When working with a lot of images data ,  this can display your image with extra info/special filters etc.

It takes a 2-D matrix or 3-D matrix as input , depending on channels of image , that is how many colors are recorded , in data.A single color is represented as intensity value.
It can vary from 1 to 255.
No of channels/colors can vary between 1-3 colors, if only 1 channel , image is black and white.
If having all 3 colors , image is a normal color image.The colors are simply RGB(Red ,Green and Blue).

For example this is an handwritten 5 , from MNIST dataset which is stored in a 2-D array.

```python
# Usage of matplotlib.pyplot.imshow()
plt.imshow(image)
plt.show()
```

{{< figure src="/images/mnist-plot-matplotlib.png" caption="Figure 4: MNIST Number in Matplotlib" >}}


### Aesthetics. {#aesthetics-dot}

Graphs being almost 100% visual feedback , you might need to add some bling to it.
Matplotlib supports everything a graph might have.Make sure to read it's documentation later.

To add label to any plot/scatter , just add label argument.Label make it easy to spot , when multiple plots are present.
You can also add label to x-axis and y-axis using methods like `plt.xlabel()` and `plt.ylabel()`.

```python
plt.xlabel('Speed')
plt.ylabel('Distance')
```

You can add title to your graphs using `plt.title()` method.

You can also add `text` to the graph , using the `plt.text()` method.For using this , you have to provide a coordinate and the text to plot.
This text can be customized (Color , Border etc).

```python
plt.scatter(x_coordinates,y_coordinates,label='Group 1')
for x,y in zip(x_coordinates,y_coordinates):
    plt.text(x,y,'Point ({x},{y})'.format(x=x,y=y))
    plt.show()
```

{{< figure src="/images/labels-matplotlib.png" caption="Figure 5: Labels in Matplotlib" >}}

To plot one graph over another , use the plot/scatter function without using `plt.show()` or `plt.savefig()` first.

```python
plt.plot([ 3 , 5 , 7] , [ 3 , 5 , 7],label='Line y=x')
plt.scatter([ 5 , 6 ] , [ 2, 5 ] , label='Group of people')
plt.show()
```

{{< figure src="/images/multiple-plot-matplotlib.png" caption="Figure 6: Multiple Plots in Matplotlib" >}}

To show a legend in the graph use the `plt.legend()` function .

```python
plt.plot([ 3 , 5 , 7] , [ 3 , 5 , 7],label='Line y=x')
plt.scatter([ 5 , 6 ] , [ 2, 5 ] , label='Group of people')
plt.legend()
plt.show()
```

You can customize plotting style by , specifying parameters such as

-   LineStyle: Using `linestyle` parameter to customize the line-drawn.
-   LineWidth: Using `linewidth` parameter to increase thickness of the line.
-   Marker: Using `marker` parameter , this changes how actual points are shown in the graph.See here for all the marker codes.
-   Color: Using color parameter, this changes color of the line drawn, see here for all the color codes.

This graph uses linestyle of `--` and linewidth of 3.5 ,marker type of `+` and color green.

```python
plt.plot(x_coodinates,y_coordinates,label='Line',linestyle='--',linewidth=3.5,marker='+',color='g')
plt.show()
```

{{< figure src="/images/ultimate-custom-matplotlib.png" >}}

You can also customize matplotlib itself, using `styles`.
By default matplotlib's style is boring,I am using dracula style for my graphs.You can change everything from fonts to background. More info is present in matplotlib's documentation.
If you want to learn to use matplotlib , you have to read it.

Anyway , here's how to use a default dark-style(included in matplotlib).

```python
plt.style.use('dark_background')

```


### Bon Voyage! {#bon-voyage}

That's basic matplotlib for you.You should definately look at their documentation.
You can also look at the Object API for matplotlib. It is a little advanced , but is highly configurable.

With the required info, you can make basic graphs , with text. I personally use matplotlib to create graphs for my Physics classes and of-course Data Visualization in ML.
