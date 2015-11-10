
# FPLabelNode

A simple subclass of ```SKNode```, which supports multiple lines and automatic line breaking.

* Language: Swift 2.1
* Requirements: SpriteKit

## License

This software is created by K.-C. Pan and can be included as a part of any software-project free of charge. No credits are required, but aknowledgement in any form is appreciated.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Functions

* Display multiple lines
* Autmatic line breaking (by words or by characters)
* Dynamically add more text
* Autoclear text when filled

## Usage

Just like the original ```SKLabelNode```

```swift
let label = FPLabelNode(fontNamed:"Helvetica")
```

Simple setup

```swift
label.width = CGRectGetMaxX(self.frame)
label.height = CGRectGetMaxY(self.frame)
label.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)
self.addChild(label)

```

Full setup 

```swift
label.width = CGRectGetMaxX(self.frame)
label.height = CGRectGetMaxY(self.frame)
label.fontColor = SKColor.blackColor()
label.fontSize = 40
label.spacing  = 1.5
label.buffer   = 80                        // buffer for the edge
label.verticalAlignmentMode = .Center      // default = .Center
label.horizontalAlignmentMode = .Center    // default = .Center
label.splitMode = .Word                    // defulat = .Word
label.position = CGPoint(x: 20, y: CGRectGetMaxY(self.frame) - 50)
self.addChild(label)
```

Push text

```swift
label.pushText("A string")
```

Push an array of string

```swift
label.pushTexts(["Line 1","Line 2", "Line 3"])
```

If you want to split your string by ```"\n"```,

```swift
label.pushString("This string\n can be \nsplit to \nfour lines.")
```

## Installing

just copy the ```FPLabelNode.swift``` to your project.
 
