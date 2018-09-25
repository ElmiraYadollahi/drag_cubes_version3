import QtQuick 2.4
import QtQuick.Controls 1.2

import QtQuick.Window 2.2
//import QtQuick.Controls 1.4

Window {
    id: win
    width: 1400
    height: 600
    title: "Drag & drop example"
    visible: true

    Rectangle {
        id: main
        width: 1400
        height: 600
        color: "white"
        //Drag.active: mouseArea.drag.active

        MouseArea{
            id: mainArea
            anchors.fill: parent
            //hoverEnabled: true
            onEntered: {
                console.log("mainArea", "entered");
            }
            onExited: {
                console.log("mainArea", "exited");
            }
        }


    }



    property var totalZoneList: ["total1", "total2", "total3"]
    property var moduleZoneList: ["module1", "module2", "module3"]
    property var totalBeadList: ["bead1", "bead2", "bead3", "bead4", "bead5", "bead6", "bead7", "bead8", "bead9", "bead10"]
    property var totalBeadList2: ["bead1", "bead2", "bead3", "bead4", "bead5", "bead6", "bead7", "bead8", "bead9", "bead10"]
    property var totalBeadList3: ["bead1", "bead2", "bead3", "bead4", "bead5", "bead6", "bead7", "bead8", "bead9", "bead10"]
    property int beadWidth:60
    property int beadHeight:60
    property int borderWidth:1100
    property int borderHeight:450
    property int bordermin: 36
    property int tolstatic:3
    property int toldynamic:1
    property int toladjusted:3
    property int row1counter: 0
    property int row2counter: 0
    property int row3counter: 0



    Rectangle {
        width: 100
        height: 100
        y: 125 + 0*150 - width/2
        x: 1100 + width/2
        border.width : 5
        border.color : "lightgrey"
        Text {
            anchors.centerIn: parent
            font.pointSize: 30
            text: row1counter
            color: "grey"
        }
        //color: "grey"
        //Drag.active: mouseArea.drag.active
    }

    Rectangle {
        width: 100
        height: 100
        y: 125 + 1*150 - width/2
        x: 1100 + width/2
        border.width : 5
        border.color : "lightgrey"
        Text {
            anchors.centerIn: parent
            font.pointSize: 30
            text: row2counter
            color: "grey"
        }
        //color: "grey"
        //Drag.active: mouseArea.drag.active
    }

    Rectangle {
        width: 100
        height: 100
        y: 125 + 2*150 - width/2
        x: 1100 + width/2
        border.width : 5
        border.color : "lightgrey"
        Text {
            anchors.centerIn: parent
            font.pointSize: 30
            text: row3counter
            color: "grey"
        }
        //color: "grey"
        //Drag.active: mouseArea.drag.active
    }


    Repeater{
        model: 3

        Rectangle {
            y: 125 + index *150
            x: 25
            height: 4
            width: borderWidth
            color: "grey"
        }
    }

    Repeater {
        model: 2

        Rectangle {
            y: 50 + index *borderHeight
            x: 25
            height: 10
            width: borderWidth + 10
            color: "grey"
        }

    }

    Repeater {
        model: 2

        Rectangle {
            y: 50
            x: 25 + index *borderWidth
            height: borderHeight + 10
            width: 10
            color: "grey"
        }
    }



    Repeater {
        id: iRepeater

        model: ListModel {
            id: myModel
            function createModel() {
                for(var i = 0; i < totalBeadList.length; i++)
                {
                    myModel.append({"item1": totalBeadList[i]})
                    //myModel.append({"item2": totalBeadList[i]})
                    //myModel.append({"item3": totalBeadList[i]})
                }
            }
            Component.onCompleted: {createModel()}
        }
        delegate: row1
    }

    Repeater {
        id: iRepeater2

        model: ListModel {
            id: myModel2
            function createModel() {
                for(var j = 0; j < totalBeadList2.length; j++)
                {
                    //myModel2.append({"item1": totalBeadList[i]})
                    myModel2.append({"item2": totalBeadList2[j]})
                    //myModel.append({"item3": totalBeadList[i]})
                }
            }
            Component.onCompleted: {createModel()}
        }
        delegate: row2
    }

    Repeater {
        id: iRepeater3

        model: ListModel {
            id: myModel3
            function createModel() {
                for(var j = 0; j < totalBeadList3.length; j++)
                {
                    //myModel2.append({"item1": totalBeadList[i]})
                    //myModel2.append({"item2": totalBeadList2[j]})
                    myModel3.append({"item3": totalBeadList[j]})
                }
            }
            Component.onCompleted: {createModel()}
        }
        delegate: row3
    }



    Component{
        id: row1



        Rectangle {
            id: rectRow1
            width: beadWidth
            height: beadHeight
            z: mouseArea.drag.active ||  mouseArea.pressed ? 2 : 1
            color: Qt.rgba(Math.random(), 0, 0, 1)
            //color: "lightgrey"

            x: index*(beadWidth+tolstatic) + 36
            //x: borderWidth - 36 - index*(beadWidth+tolstatic)
            y: 100

            property int offsetX:0
            property int offsetY:0
            property bool selected: false
            property point beginDrag
            property point beginDrag2
            property bool caught: false
            property real oldMouseX:0
            property real xDiff:0
            property bool flagR: false
            property bool sepFlagR: false
            property bool flagL: false
            property bool sepFlagL: false
            property bool rightDirection: false
            property bool leftDirection: false
            property int oldX: 0
            property int sepCounter: 0
            property int savei: 0
            property int connected: 0
            property bool endhit: true
            property int counter:0
            property bool lastbeadcase:false
            property bool firstbeadcase:false
            property bool lonelybead: false
            property bool groupbead: false
            property int helpcounter: 0


            radius: 5
            Drag.active: mouseArea.drag.active
            Text {
                anchors.centerIn: parent
                text: index
                color: "white"
            }

            function setRelative(pressedRect){
                disableDrag();
                x = Qt.binding(function (){ return pressedRect.x + offsetX; })
                y = Qt.binding(function (){ return pressedRect.y + offsetY; })
            }
            function enableDrag(){
                mouseArea.drag.target = rectRow1
            }
            function disableDrag(){
                mouseArea.drag.target = null
            }

            function tracking(tracked, moved, xDist){
                Qt.binding(
                            function()
                            {

                                moved.x += tracked.x + xDist


                                return moved.x;
                            }
                            )
            }
            onXChanged: {
                if (mouseArea.drag.active) {
                    xDiff = x-oldX
                    if (xDiff > 0) {
                        rightDirection = true
                        leftDirection = false
                        console.log("right");
                    }
                    if (xDiff < 0) {
                        leftDirection = true
                        rightDirection = false
                        console.log("left");
                    }


                    oldX = x
                }
            }

            MouseArea {
                //***** MouseArea basic definitions
                id: mouseArea
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                //hoverEnabled: true

                onEntered: {
                }
                onExited: {
                }

                onPositionChanged: {
                    //***** Defining the areas to work with for each bead
                    console.log("index", index);
                    var rectC = iRepeater.itemAt(index)
                    var rectN = iRepeater.itemAt(index + 1)
                    var rectB = iRepeater.itemAt(index - 1)

                    rectC.beginDrag = Qt.point(rectC.x, rectC.y);
                    var pressedRect = iRepeater.itemAt(index);
                    var pressedRectL = iRepeater.itemAt(index);
                    pressedRect.enableDrag()

                    //***** Max and Min Limitations on bead movements
                    if (index == 0){
                        drag.minimumX = 36;
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead 0 - dragmin - dragmax", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("bead 0 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }
                    else if (index == totalBeadList.length -1){
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = borderWidth - (beadWidth/2 + 6);
                        console.log("bead 9 - dragmin - dragmax", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("bead 9 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }else{
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead middle - dragmin - dragmax", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("middle right - dragmin - dragmax", drag.minimumX, drag.maximumX);
                        }
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("middle left - dragmin - dragmax", drag.minimumX, drag.maximumX);
                        }
                    }

                    //****** Condition for the last bead
                    if (index == iRepeater.count-1){
                        if (!groupbead){
                            var rect = iRepeater.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = rectB.x + (beadWidth+toldynamic);
                            drag.maximumX = borderWidth - (beadWidth/2 + 6);
                            console.log("Condition - last bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //****** Conditin for the first bead
                    if (index == 0){
                        if (!groupbead){
                            var rect = iRepeater.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = 36;
                            drag.maximumX = rectN.x - (beadWidth+tolstatic);
                            console.log("dragmax - first bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //***** Condition for a bead that is not connected to any bead before it
                    if (index > 0  && rectC.x !== rectB.x + (beadWidth+tolstatic)  ){
                        for (var i=index+1; i<iRepeater.count; i++ ){
                            var rect = iRepeater.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - left empty", rectC.x);
                        lonelybead = true
                    }

                    //***** Condition for a bead that is not connected to any bead after it
                    if (index < iRepeater.count-1  && rectC.x !== rectN.x - (beadWidth+tolstatic ) ){
                        for (var i=index-1; i>0; i-- ){
                            var rect = iRepeater.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - right empty", rectC.x);
                        lonelybead = true
                    }

                    // ***** Condition for a bead that is connected to other beads on both sides - moving left
                    if (index > 0){
                        if ((iRepeater.itemAt(index)).x <= (iRepeater.itemAt(index-1)).x + (beadWidth+toldynamic)){
                            for (var i=index; i>=0; i-- ){
                                var rect = iRepeater.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagL = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagL && i > 0 &&  (iRepeater.itemAt(i+1)).x <= (iRepeater.itemAt(i)).x + (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - move left - attached to next", drag.minimumX);
                                        flagL = true
                                        firstbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagL &&  (iRepeater.itemAt(i+1)).x <= (iRepeater.itemAt(i)).x + (beadWidth+toldynamic) && i == 0 ) {
                                        console.log("Condition - middle bead - move left - attached to last", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        firstbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - move left - not attached", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagL){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmin - move left - connected bead", drag.minimumX);
                                }else if (!flagL  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagL = true
                                    if (sepCounter == 1){
                                        drag.minimumX = (iRepeater.itemAt(savei)).x - (index - savei)*(beadWidth+toldynamic)
                                        if (savei == 0 && firstbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.minimumX = 36 +  (index - savei)*(beadWidth+toldynamic)

                                        }
                                        console.log("dragmax - move left - added bead", drag.minimumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }

                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagL = false
                        }//##### ((iRepeater.itemAt(index)).x === (iRepeater.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index > 0)

                    //***** Condition for a bead that is connected to other beads on both sides - moving right
                    if (index < iRepeater.count -1){
                        if ((iRepeater.itemAt(index)).x >= (iRepeater.itemAt(index+1)).x - (beadWidth+toldynamic)){

                            console.log("Condition - middle bead - both full", drag.maximumX);
                            for (var i=index; i<iRepeater.count; i++ ){
                                var rect = iRepeater.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagR = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagR && i < (iRepeater.count-1) &&  (iRepeater.itemAt(i-1)).x >= (iRepeater.itemAt(i)).x - (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - attached to next", drag.maximumX);
                                        flagR = true
                                        lastbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagR &&  (iRepeater.itemAt(i-1)).x >= (iRepeater.itemAt(i)).x - (beadWidth+toldynamic) && i == iRepeater.count-1 ) {
                                        console.log("Condition - middle bead - attached to last", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        lastbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - not attached", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagR){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmax - connected bead", drag.maximumX);
                                }else if (!flagR  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagR = true
                                    if (sepCounter == 1){
                                        drag.maximumX = (iRepeater.itemAt(savei)).x - (savei - index)*(beadWidth+toldynamic)
                                        if (savei == 9 && lastbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.maximumX = borderWidth - (beadWidth/2 + 6 ) - (savei - index)*(beadWidth+toldynamic)
                                        }
                                        console.log("dragmax - added bead", drag.maximumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }
                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagR = false
                        }//##### ((iRepeater.itemAt(index)).x === (iRepeater.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index < iRepeater.count -1)
                    console.log("*");
                    console.log("*");
                    pressedRect.enableDrag()
                    groupbead = false

                }// ##### On positionChanged



                onPressed: {
                    var pressedRect = iRepeater.itemAt(index);
                    pressedRect.enableDrag()
                }//onPressed



                onReleased: {
                    counter = 0
                    var rectC = iRepeater.itemAt(index)
                    var rectN = iRepeater.itemAt(index + 1)
                    var rectB = iRepeater.itemAt(index - 1)
                    var pressedRect = iRepeater.itemAt(index);
                    pressedRect.enableDrag()

                    var rectN = iRepeater.itemAt(index+1);

                    for (var i=0; i<iRepeater.count; i++ ){
                        var rect = iRepeater.itemAt(i);
                        rect.x = rect.x
                        rect.y = rect.y
                        rect.disableDrag()
                        pressedRect.enableDrag()
                    }
                    for (var k=iRepeater.count-1; k>index; k-- ){
                        console.log("diff log", "bead", k, "Diff", iRepeater.itemAt(k).x - iRepeater.itemAt(k-1).x - (beadWidth));
                        if ((iRepeater.itemAt(k).x - iRepeater.itemAt(k-1).x - (beadWidth)) < toladjusted){
                            iRepeater.itemAt(k-1).x = iRepeater.itemAt(k).x - (beadWidth) - toladjusted
                            console.log("does it work");
                            console.log("diff log","bead", k, "Diff", iRepeater.itemAt(k).x - iRepeater.itemAt(k-1).x - (beadWidth));
                        }
                    }
                    console.log("break");

                    for (var k=0; k<index; k++){
                        console.log("diff log", "bead", k, "Diff",  iRepeater.itemAt(k+1).x - iRepeater.itemAt(k).x - (beadWidth));
                        if (iRepeater.itemAt(k+1).x - iRepeater.itemAt(k).x - (beadWidth) < toladjusted){
                            iRepeater.itemAt(k+1).x = iRepeater.itemAt(k).x + (beadWidth) + toladjusted
                            console.log("did it change?");
                            console.log("diff log", "bead", k, "Diff", iRepeater.itemAt(k+1).x - iRepeater.itemAt(k).x - (beadWidth));
                        }
                    }

                    rightDirection = false
                    leftDirection = false
                    lonelybead = true

                    if (rect.caught) {
                        backAnimX.from = rect.x;
                        backAnimX.to = beginDrag.x;
                        backAnimY.from = rect.y;
                        backAnimY.to = rect.y;
                        backAnim.start()
                        if (index != iRepeater.count -1){
                            backAnimXN.from = rectN.x;
                            backAnimXN.to = beginDrag2.x;
                            backAnimYN.from = rectN.y;
                            backAnimYN.to = rectN.y;
                            backAnim.start()
                        }
                    }
                    if (rect.x !== model.x) {
                    } else {
                        rect.x = 10
                        rect.y = 30
                    }


                    // ***** Count the rows
                    for (var c=0; c<iRepeater.count; c++){
                        if (iRepeater.itemAt(c).x < ((c+3) * (beadWidth + tolstatic) + 36)){
                            //console.log("((c+1) * beadwidth + 36)", c, iRepeater.itemAt(c).x, ((c+3) * (beadWidth + tolstatic) + 36));
                            helpcounter = helpcounter + 1
                        }
                    }
                    row1counter = 10 - helpcounter
                    helpcounter = 0



                } //##### onReleased

            } //##### MouseArea

            ParallelAnimation {
                id: backAnim
                SpringAnimation { id: backAnimX; target: iRepeater.itemAt(index); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimY; target: iRepeater.itemAt(index); property: "y"; duration: 500; spring: 2; damping: 0.2 }

                SpringAnimation { id: backAnimXN; target: iRepeater.itemAt(index+1); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimYN; target: iRepeater.itemAt(index+1); property: "y"; duration: 500; spring: 2; damping: 0.2 }

            } //##### ParallelAnimation

            DropArea {
                anchors.fill: parent
                onEntered: drag.source.caught = true;
                onExited: drag.source.caught = false;
            } //##### Droparea
        } //##### Rectangle
    } //##### Component



    Component{
        id: row2


        Rectangle {
            id: rectRow2

            width: beadWidth
            height: beadHeight
            z: mouseArea2.drag.active ||  mouseArea2.pressed ? 2 : 1
            color: Qt.rgba(0, 0, Math.random(), 1)
            //color: "grey"

            x: index*(beadWidth+tolstatic) + 36
            y: 250

            property int offsetX:0
            property int offsetY:0
            property bool selected: false
            property point beginDrag
            property point beginDrag2
            property bool caught: false
            property real oldMouseX:0
            property real xDiff:0
            property bool flagR: false
            property bool sepFlagR: false
            property bool flagL: false
            property bool sepFlagL: false
            property bool rightDirection: false
            property bool leftDirection: false
            property int oldX: 0
            property int sepCounter: 0
            property int savei: 0
            property int connected: 0
            property bool endhit: true
            property int counter:0
            property bool lastbeadcase:false
            property bool firstbeadcase:false
            property bool lonelybead: false
            property bool groupbead: false
            property int helpcounter: 0



            radius: 5
            Drag.active: mouseArea2.drag.active
            Text {
                anchors.centerIn: parent
                text: index
                color: "white"
            }

            function setRelative(pressedRect){
                disableDrag();
                x = Qt.binding(function (){ return pressedRect.x + offsetX; })
                y = Qt.binding(function (){ return pressedRect.y + offsetY; })
            }
            function enableDrag(){
                mouseArea2.drag.target = rectRow2
            }
            function disableDrag(){
                mouseArea2.drag.target = null
            }

            function tracking(tracked, moved, xDist){
                Qt.binding(
                            function()
                            {

                                moved.x += tracked.x + xDist


                                return moved.x;
                            }
                            )
            }
            onXChanged: {
                if (mouseArea2.drag.active) {
                    xDiff = x-oldX
                    if (xDiff > 0) {
                        rightDirection = true
                        leftDirection = false
                        console.log("right");
                    }
                    if (xDiff < 0) {
                        leftDirection = true
                        rightDirection = false
                        console.log("left");
                    }


                    oldX = x
                }
            }

            MouseArea {
                //***** MouseArea basic definitions
                id: mouseArea2
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                //hoverEnabled: true

                onEntered: {
                }
                onExited: {
                }

                onPositionChanged: {
                    //***** Defining the areas to work with for each bead
                    console.log("index", index);
                    var rectC = iRepeater2.itemAt(index)
                    var rectN = iRepeater2.itemAt(index + 1)
                    var rectB = iRepeater2.itemAt(index - 1)

                    rectC.beginDrag = Qt.point(rectC.x, rectC.y);
                    var pressedRect = iRepeater2.itemAt(index);
                    var pressedRectL = iRepeater2.itemAt(index);
                    pressedRect.enableDrag()

                    //***** Max and Min Limitations on bed movements
                    if (index == 0){
                        drag.minimumX = 36;
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead 0 - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("bead 0 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }
                    else if (index == totalBeadList.length -1){
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = borderWidth - (beadWidth/2 + 6);
                        console.log("bead 9 - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("bead 9 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }else{
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead middle - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("middle right - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        }
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("middle left - dragmax - dragmin", drag.minimumX, drag.maximumX);

                        }
                    }

                    //****** Condition for the last bead
                    if (index == iRepeater2.count-1){
                        if (!groupbead){
                            var rect = iRepeater2.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = rectB.x + (beadWidth+toldynamic);
                            drag.maximumX = borderWidth - (beadWidth/2 + 6);
                            console.log("Condition - last bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //****** Conditin for the first bead
                    if (index == 0){
                        if (!groupbead){
                            var rect = iRepeater2.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = 36;
                            drag.maximumX = rectN.x - (beadWidth+tolstatic);
                            console.log("dragmax - first bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //***** Condition for a bead that is not connected to any bead before it
                    if (index > 0  && rectC.x !== rectB.x + (beadWidth+tolstatic)  ){
                        for (var i=index+1; i<iRepeater2.count; i++ ){
                            var rect = iRepeater2.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - left empty", rectC.x);
                        lonelybead = true
                    }

                    //***** Condition for a bead that is not connected to any bead after it
                    if (index < iRepeater2.count-1  && rectC.x !== rectN.x - (beadWidth+tolstatic ) ){
                        for (var i=index-1; i>0; i-- ){
                            var rect = iRepeater2.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - right empty", rectC.x);
                        lonelybead = true
                    }

                    // ***** Condition for a bead that is connected to other beads on both sides - moving left
                    if (index > 0){
                        if ((iRepeater2.itemAt(index)).x <= (iRepeater2.itemAt(index-1)).x + (beadWidth+toldynamic)){
                            for (var i=index; i>=0; i-- ){
                                var rect = iRepeater2.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagL = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagL && i > 0 &&  (iRepeater2.itemAt(i+1)).x <= (iRepeater2.itemAt(i)).x + (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - move left - attached to next", drag.minimumX);
                                        flagL = true
                                        firstbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagL &&  (iRepeater2.itemAt(i+1)).x <= (iRepeater2.itemAt(i)).x + (beadWidth+toldynamic) && i == 0 ) {
                                        console.log("Condition - middle bead - move left - attached to last", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        firstbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - move left - not attached", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagL){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmin - move left - connected bead", drag.minimumX);
                                }else if (!flagL  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagL = true
                                    if (sepCounter == 1){
                                        drag.minimumX = (iRepeater2.itemAt(savei)).x - (index - savei)*(beadWidth+toldynamic)
                                        if (savei == 0 && firstbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.minimumX = 36 +  (index - savei)*(beadWidth+toldynamic)

                                        }
                                        console.log("dragmax - move left - added bead", drag.minimumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }

                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagL = false
                        }//##### ((iRepeater2.itemAt(index)).x === (iRepeater2.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index > 0)

                    //***** Condition for a bead that is connected to other beads on both sides - moving right
                    if (index < iRepeater2.count -1){
                        if ((iRepeater2.itemAt(index)).x >= (iRepeater2.itemAt(index+1)).x - (beadWidth+toldynamic)){

                            console.log("Condition - middle bead - both full", drag.maximumX);
                            for (var i=index; i<iRepeater2.count; i++ ){
                                var rect = iRepeater2.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagR = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagR && i < (iRepeater2.count-1) &&  (iRepeater2.itemAt(i-1)).x >= (iRepeater2.itemAt(i)).x - (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - attached to next", drag.maximumX);
                                        flagR = true
                                        lastbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagR &&  (iRepeater2.itemAt(i-1)).x >= (iRepeater2.itemAt(i)).x - (beadWidth+toldynamic) && i == iRepeater2.count-1 ) {
                                        console.log("Condition - middle bead - attached to last", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        lastbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - not attached", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagR){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmax - connected bead", drag.maximumX);
                                }else if (!flagR  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagR = true
                                    if (sepCounter == 1){
                                        drag.maximumX = (iRepeater2.itemAt(savei)).x - (savei - index)*(beadWidth+toldynamic)
                                        if (savei == 9 && lastbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.maximumX = borderWidth - (beadWidth/2 + 6 ) - (savei - index)*(beadWidth+toldynamic)
                                        }
                                        console.log("dragmax - added bead", drag.maximumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }
                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagR = false
                        }//##### ((iRepeater2.itemAt(index)).x === (iRepeater2.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index < iRepeater2.count -1)
                    console.log("*");
                    console.log("*");
                    pressedRect.enableDrag()
                    groupbead = false

                }// ##### On positionChanged



                onPressed: {
                    var pressedRect = iRepeater2.itemAt(index);
                    pressedRect.enableDrag()
                }//onPressed



                onReleased: {
                    counter = 0
                    var rectC = iRepeater2.itemAt(index)
                    var rectN = iRepeater2.itemAt(index + 1)
                    var rectB = iRepeater2.itemAt(index - 1)
                    var pressedRect = iRepeater2.itemAt(index);
                    pressedRect.enableDrag()

                    var rectN = iRepeater2.itemAt(index+1);

                    for (var i=0; i<iRepeater2.count; i++ ){
                        var rect = iRepeater2.itemAt(i);
                        rect.x = rect.x
                        rect.y = rect.y
                        rect.disableDrag()
                        pressedRect.enableDrag()
                    }


                    for (var k=iRepeater2.count-1; k>index; k-- ){
                        console.log("diff log", "bead", k, "Diff", iRepeater2.itemAt(k).x - iRepeater2.itemAt(k-1).x - (beadWidth));
                        if ((iRepeater2.itemAt(k).x - iRepeater2.itemAt(k-1).x - (beadWidth)) < toladjusted){
                            iRepeater2.itemAt(k-1).x = iRepeater2.itemAt(k).x - (beadWidth) - toladjusted
                            console.log("does it work");
                            console.log("diff log", "bead", k, "Diff", iRepeater2.itemAt(k).x - iRepeater2.itemAt(k-1).x - (beadWidth));
                        }
                    }
                    console.log("break");

                    for (var k=0; k<index; k++){
                        console.log("diff log", "bead", k, "Diff", iRepeater2.itemAt(k+1).x - iRepeater2.itemAt(k).x - (beadWidth));
                        if (iRepeater2.itemAt(k+1).x - iRepeater2.itemAt(k).x - (beadWidth) < toladjusted){
                            iRepeater2.itemAt(k+1).x = iRepeater2.itemAt(k).x + (beadWidth) + toladjusted
                            console.log("did it change?");
                            console.log("diff log", "bead", k, "Diff", iRepeater2.itemAt(k+1).x - iRepeater2.itemAt(k).x - (beadWidth));
                        }
                    }

                    rightDirection = false
                    leftDirection = false
                    lonelybead = true

                    if (rect.caught) {
                        backAnimX.from = rect.x;
                        backAnimX.to = beginDrag.x;
                        backAnimY.from = rect.y;
                        backAnimY.to = rect.y;
                        backAnim.start()
                        if (index != iRepeater2.count -1){
                            backAnimXN.from = rectN.x;
                            backAnimXN.to = beginDrag2.x;
                            backAnimYN.from = rectN.y;
                            backAnimYN.to = rectN.y;
                            backAnim.start()
                        }
                    }
                    if (rect.x !== model.x) {
                    } else {
                        rect.x = 10
                        rect.y = 30
                    }

                    // ***** Count the rows
                    for (var c=0; c<iRepeater2.count; c++){
                        if (iRepeater2.itemAt(c).x < ((c+3) * (beadWidth + tolstatic) + 36)){
                            //console.log("((c+1) * beadwidth + 36)", c, iRepeater2.itemAt(c).x, ((c+3) * (beadWidth + tolstatic) + 36));
                            helpcounter = helpcounter + 1
                        }
                    }// ##### for counter
                    row2counter = 10 - helpcounter
                    helpcounter = 0

                } //##### onReleased

            } //##### mouseArea2

            ParallelAnimation {
                id: backAnim
                SpringAnimation { id: backAnimX; target: iRepeater2.itemAt(index); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimY; target: iRepeater2.itemAt(index); property: "y"; duration: 500; spring: 2; damping: 0.2 }

                SpringAnimation { id: backAnimXN; target: iRepeater2.itemAt(index+1); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimYN; target: iRepeater2.itemAt(index+1); property: "y"; duration: 500; spring: 2; damping: 0.2 }

            } //##### ParallelAnimation

            DropArea {
                anchors.fill: parent
                onEntered: drag.source.caught = true;
                onExited: drag.source.caught = false;
            } //##### Droparea
        } //##### Rectangle
    } //##### Component



    Component{
        id: row3


        Rectangle {
            id: rectRow3

            width: beadWidth
            height: beadHeight
            z: mouseArea3.drag.active ||  mouseArea3.pressed ? 2 : 1
            color: Qt.rgba(0, Math.random(), 0, 1)
            //color: "black"

            x: index*(beadWidth+tolstatic) + 36
            y: 400

            property int offsetX:0
            property int offsetY:0
            property bool selected: false
            property point beginDrag
            property point beginDrag2
            property bool caught: false
            property real oldMouseX:0
            property real xDiff:0
            property bool flagR: false
            property bool sepFlagR: false
            property bool flagL: false
            property bool sepFlagL: false
            property bool rightDirection: false
            property bool leftDirection: false
            property int oldX: 0
            property int sepCounter: 0
            property int savei: 0
            property int connected: 0
            property bool endhit: true
            property int counter:0
            property bool lastbeadcase:false
            property bool firstbeadcase:false
            property bool lonelybead: false
            property bool groupbead: false
            property int helpcounter: 0


            radius: 5
            Drag.active: mouseArea3.drag.active
            Text {
                anchors.centerIn: parent
                text: index
                color: "white"
            }

            function setRelative(pressedRect){
                disableDrag();
                x = Qt.binding(function (){ return pressedRect.x + offsetX; })
                y = Qt.binding(function (){ return pressedRect.y + offsetY; })
            }
            function enableDrag(){
                mouseArea3.drag.target = rectRow3
            }
            function disableDrag(){
                mouseArea3.drag.target = null
            }

            function tracking(tracked, moved, xDist){
                Qt.binding(
                            function()
                            {

                                moved.x += tracked.x + xDist


                                return moved.x;
                            }
                            )
            }
            onXChanged: {
                if (mouseArea3.drag.active) {
                    xDiff = x-oldX
                    if (xDiff > 0) {
                        rightDirection = true
                        leftDirection = false
                        console.log("right");
                    }
                    if (xDiff < 0) {
                        leftDirection = true
                        rightDirection = false
                        console.log("left");
                    }


                    oldX = x
                }
            }

            MouseArea {
                //***** MouseArea basic definitions
                id: mouseArea3
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                //hoverEnabled: true

                onEntered: {
                }
                onExited: {
                }

                onPositionChanged: {
                    //***** Defining the areas to work with for each bead
                    console.log("index", index);
                    var rectC = iRepeater3.itemAt(index)
                    var rectN = iRepeater3.itemAt(index + 1)
                    var rectB = iRepeater3.itemAt(index - 1)

                    rectC.beginDrag = Qt.point(rectC.x, rectC.y);
                    var pressedRect = iRepeater3.itemAt(index);
                    var pressedRectL = iRepeater3.itemAt(index);
                    pressedRect.enableDrag()

                    //***** Max and Min Limitations on bed movements
                    if (index == 0){
                        drag.minimumX = 36;
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead 0 - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("bead 0 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }
                    else if (index == totalBeadList.length -1){
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = borderWidth - (beadWidth/2 + 6);
                        console.log("bead 9 - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("bead 9 - all beads - dragmin - dragmax", drag.minimumX, drag.maximumX);
                            groupbead = true
                        }
                    }else{
                        drag.minimumX = rectB.x + (beadWidth+toldynamic);
                        drag.maximumX = rectN.x - (beadWidth+toldynamic);
                        console.log("bead middle - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        if (rectC.x === rectN.x - (beadWidth+tolstatic)){
                            drag.maximumX = borderWidth - (beadWidth/2 +6) - (9 - index)*(beadWidth + toldynamic)
                            console.log("middle right - dragmax - dragmin", drag.minimumX, drag.maximumX);
                        }
                        if (rectC.x === rectB.x + (beadWidth+tolstatic)){
                            drag.minimumX = 36 +  (index)*(beadWidth + toldynamic)
                            console.log("middle left - dragmax - dragmin", drag.minimumX, drag.maximumX);

                        }
                    }

                    //****** Condition for the last bead
                    if (index == iRepeater3.count-1){
                        if (!groupbead){
                            var rect = iRepeater3.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = rectB.x + (beadWidth+toldynamic);
                            drag.maximumX = borderWidth - (beadWidth/2 + 6);
                            console.log("Condition - last bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //****** Conditin for the first bead
                    if (index == 0){
                        if (!groupbead){
                            var rect = iRepeater3.itemAt(index);
                            rect.disableDrag()
                            pressedRect.enableDrag()
                            drag.minimumX = 36;
                            drag.maximumX = rectN.x - (beadWidth+tolstatic);
                            console.log("dragmax - first bead", drag.maximumX);
                            lonelybead = true
                        }
                    }

                    //***** Condition for a bead that is not connected to any bead before it
                    if (index > 0  && rectC.x !== rectB.x + (beadWidth+tolstatic)  ){
                        for (var i=index+1; i<iRepeater3.count; i++ ){
                            var rect = iRepeater3.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - left empty", rectC.x);
                        lonelybead = true
                    }

                    //***** Condition for a bead that is not connected to any bead after it
                    if (index < iRepeater3.count-1  && rectC.x !== rectN.x - (beadWidth+tolstatic ) ){
                        for (var i=index-1; i>0; i-- ){
                            var rect = iRepeater3.itemAt(i);
                            rect.x = rect.x
                            rect.y = rect.y
                            rect.disableDrag()
                            pressedRect.enableDrag()
                        }
                        console.log("Condition - middle bead - right empty", rectC.x);
                        lonelybead = true
                    }

                    // ***** Condition for a bead that is connected to other beads on both sides - moving left
                    if (index > 0){
                        if ((iRepeater3.itemAt(index)).x <= (iRepeater3.itemAt(index-1)).x + (beadWidth+toldynamic)){
                            for (var i=index; i>=0; i-- ){
                                var rect = iRepeater3.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagL = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagL && i > 0 &&  (iRepeater3.itemAt(i+1)).x <= (iRepeater3.itemAt(i)).x + (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - move left - attached to next", drag.minimumX);
                                        flagL = true
                                        firstbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagL &&  (iRepeater3.itemAt(i+1)).x <= (iRepeater3.itemAt(i)).x + (beadWidth+toldynamic) && i == 0 ) {
                                        console.log("Condition - middle bead - move left - attached to last", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        firstbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - move left - not attached", drag.minimumX);
                                        flagL = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagL){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmin - move left - connected bead", drag.minimumX);
                                }else if (!flagL  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagL = true
                                    if (sepCounter == 1){
                                        drag.minimumX = (iRepeater3.itemAt(savei)).x - (index - savei)*(beadWidth+toldynamic)
                                        if (savei == 0 && firstbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.minimumX = 36 +  (index - savei)*(beadWidth+toldynamic)

                                        }
                                        console.log("dragmax - move left - added bead", drag.minimumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }

                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagL = false
                        }//##### ((iRepeater3.itemAt(index)).x === (iRepeater3.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index > 0)

                    //***** Condition for a bead that is connected to other beads on both sides - moving right
                    if (index < iRepeater3.count -1){
                        if ((iRepeater3.itemAt(index)).x >= (iRepeater3.itemAt(index+1)).x - (beadWidth+toldynamic)){

                            console.log("Condition - middle bead - both full", drag.maximumX);
                            for (var i=index; i<iRepeater3.count; i++ ){
                                var rect = iRepeater3.itemAt(i);
                                if (i == index){
                                    //***** init for breaking existing binding
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    flagR = true
                                    sepCounter = 0
                                    console.log("this is for i = ", i);
                                }else {
                                    if(!sepFlagR && i < (iRepeater3.count-1) &&  (iRepeater3.itemAt(i-1)).x >= (iRepeater3.itemAt(i)).x - (beadWidth+toldynamic)){
                                        console.log("Condition - middle bead - attached to next", drag.maximumX);
                                        flagR = true
                                        lastbeadcase = false
                                        lonelybead = false
                                    }else if (!sepFlagR &&  (iRepeater3.itemAt(i-1)).x >= (iRepeater3.itemAt(i)).x - (beadWidth+toldynamic) && i == iRepeater3.count-1 ) {
                                        console.log("Condition - middle bead - attached to last", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        lastbeadcase = true
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }else {
                                        console.log("Condition - middle bead - not attached", drag.maximumX);
                                        flagR = false
                                        sepCounter = sepCounter + 1
                                        if (sepCounter == 1){savei = i}
                                        lonelybead = false
                                    }
                                }
                                if (flagR){
                                    rect.offsetX = rect.x - pressedRect.x
                                    rect.offsetY = rect.y - pressedRect.y
                                    rect.setRelative(pressedRect)
                                    console.log("dragmax - connected bead", drag.maximumX);
                                }else if (!flagR  ){
                                    rect.x = rect.x
                                    rect.y = rect.y
                                    rect.disableDrag()
                                    sepFlagR = true
                                    if (sepCounter == 1){
                                        drag.maximumX = (iRepeater3.itemAt(savei)).x - (savei - index)*(beadWidth+toldynamic)
                                        if (savei == 9 && lastbeadcase){
                                            rect.offsetX = rect.x - pressedRect.x
                                            rect.offsetY = rect.y - pressedRect.y
                                            rect.setRelative(pressedRect)
                                            drag.maximumX = borderWidth - (beadWidth/2 + 6 ) - (savei - index)*(beadWidth+toldynamic)
                                        }
                                        console.log("dragmax - added bead", drag.maximumX);
                                        console.log("Savei", savei);
                                        savei = 0
                                    }
                                }
                            }
                            console.log(".");
                            console.log(".");
                            pressedRect.enableDrag()
                            sepFlagR = false
                        }//##### ((iRepeater3.itemAt(index)).x === (iRepeater3.itemAt(index+1)).x - (beadWidth+tolstatic))
                    }//##### if index(index < iRepeater3.count -1)
                    console.log("*");
                    console.log("*");
                    pressedRect.enableDrag()
                    groupbead = false

                }// ##### On positionChanged



                onPressed: {
                    var pressedRect = iRepeater3.itemAt(index);
                    pressedRect.enableDrag()
                }//onPressed



                onReleased: {
                    counter = 0
                    var rectC = iRepeater3.itemAt(index)
                    var rectN = iRepeater3.itemAt(index + 1)
                    var rectB = iRepeater3.itemAt(index - 1)
                    var pressedRect = iRepeater3.itemAt(index);
                    pressedRect.enableDrag()

                    var rectN = iRepeater3.itemAt(index+1);

                    for (var i=0; i<iRepeater3.count; i++ ){
                        var rect = iRepeater3.itemAt(i);
                        rect.x = rect.x
                        rect.y = rect.y
                        rect.disableDrag()
                        pressedRect.enableDrag()
                    }
                    for (var k=iRepeater3.count-1; k>index; k-- ){
                        console.log("diff log", "bead", k, "Diff", iRepeater3.itemAt(k).x - iRepeater3.itemAt(k-1).x - (beadWidth));
                        if ((iRepeater3.itemAt(k).x - iRepeater3.itemAt(k-1).x - (beadWidth)) < toladjusted){
                            iRepeater3.itemAt(k-1).x = iRepeater3.itemAt(k).x - (beadWidth) - toladjusted
                            console.log("does it work");
                            console.log("diff log", "bead", k, "Diff", iRepeater3.itemAt(k).x - iRepeater3.itemAt(k-1).x - (beadWidth));
                        }
                    }
                    console.log("break");

                    for (var k=0; k<index; k++){
                        console.log("diff log", "bead", k, "Diff", iRepeater3.itemAt(k+1).x - iRepeater3.itemAt(k).x - (beadWidth));
                        if (iRepeater3.itemAt(k+1).x - iRepeater3.itemAt(k).x - (beadWidth) < toladjusted){
                            iRepeater3.itemAt(k+1).x = iRepeater3.itemAt(k).x + (beadWidth) + toladjusted
                            console.log("did it change?");
                            console.log("diff log", "bead", k, "Diff", iRepeater3.itemAt(k+1).x - iRepeater3.itemAt(k).x - (beadWidth));
                        }
                    }

                    rightDirection = false
                    leftDirection = false
                    lonelybead = true

                    if (rect.caught) {
                        backAnimX.from = rect.x;
                        backAnimX.to = beginDrag.x;
                        backAnimY.from = rect.y;
                        backAnimY.to = rect.y;
                        backAnim.start()
                        if (index != iRepeater3.count -1){
                            backAnimXN.from = rectN.x;
                            backAnimXN.to = beginDrag2.x;
                            backAnimYN.from = rectN.y;
                            backAnimYN.to = rectN.y;
                            backAnim.start()
                        }
                    }
                    if (rect.x !== model.x) {
                    } else {
                        rect.x = 10
                        rect.y = 30
                    }

                    // ***** Count the rows
                    for (var c=0; c<iRepeater3.count; c++){
                        if (iRepeater3.itemAt(c).x < ((c+3) * (beadWidth + tolstatic) + 36)){
                            console.log("((c+1) * beadwidth + 36)", c, iRepeater3.itemAt(c).x, ((c+3) * (beadWidth + tolstatic) + 36));
                            helpcounter = helpcounter + 1
                        }
                    } // ##### for counter
                    row3counter = 10 - helpcounter
                    helpcounter = 0

                } //##### onReleased

            } //##### mouseArea2

            ParallelAnimation {
                id: backAnim
                SpringAnimation { id: backAnimX; target: iRepeater3.itemAt(index); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimY; target: iRepeater3.itemAt(index); property: "y"; duration: 500; spring: 2; damping: 0.2 }

                SpringAnimation { id: backAnimXN; target: iRepeater3.itemAt(index+1); property: "x"; duration: 500; spring: 2; damping: 0.2 }
                SpringAnimation { id: backAnimYN; target: iRepeater3.itemAt(index+1); property: "y"; duration: 500; spring: 2; damping: 0.2 }

            } //##### ParallelAnimation

            DropArea {
                anchors.fill: parent
                onEntered: drag.source.caught = true;
                onExited: drag.source.caught = false;
            } //##### Droparea
        } //##### Rectangle
    } //##### Component







}


