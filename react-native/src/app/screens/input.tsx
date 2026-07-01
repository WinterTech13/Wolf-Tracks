import { useState } from "react";
import { Text, View, StyleSheet, Alert, TouchableOpacity, TextInput} from "react-native";

export default function homescreen() {
    const [pedestrianCount, setPedestrianCount] = useState([0, 0, 0, 0]);
    const [lastUpdated, setLastUpdated] = useState("");
    const [latestDataPoint, updateLatestDataPoint] = useState("");

    function updateCount(direction: number, amount: number) {
        const updatedValues = pedestrianCount.map((c, i) => {
            if (i === direction) {
                return Math.max(c + amount, 0);
            } else {
                return c;
            }
        });
        setPedestrianCount(updatedValues);
    }

    function resetCount() {
        setPedestrianCount([0, 0, 0, 0]);
    }

    function getDateString() {
        const currentDate = new Date();
        let formattedDate = currentDate.toLocaleDateString('en-US', {
            month: '2-digit',
            day: '2-digit',
            year: 'numeric'
        }) + ' ' + currentDate.toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });
        setLastUpdated(formattedDate);
        return formattedDate;
    }

    function newDataPoint() {
        let exportString = "";
        exportString += getDateString();
        exportString += ",5,";
        exportString += pedestrianCount[0] + ",";
        exportString += pedestrianCount[1] + ",";
        exportString += pedestrianCount[2] + ",";
        exportString += pedestrianCount[3];
        resetCount();
        updateLatestDataPoint(exportString);
    }

    return (
        <View style={styles.container}>
            <View>
                <Text style={styles.headerText}>Data Collection</Text>
            </View>
            <View style={styles.rowView}>
                <Text style={styles.standardText}>Last Updated: {lastUpdated}</Text>
            </View>
            <View style={styles.rowView}>
                <Text style={styles.standardText}>Location: </Text>
                <TextInput
                    style={styles.inputConfig}
                    placeholderTextColor="#eeeeee"
                    placeholder="Test"
                    textAlign="left"
                />
            </View>
            <View style={styles.rowView}>
                <Text style={styles.standardText}>North</Text>
                <Text style={styles.standardText}>South</Text>
                <Text style={styles.standardText}>East</Text>
                <Text style={styles.standardText}>West</Text>
            </View>
            <View style={styles.rowView}>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(0, 1)}
                    >
                    <Text style={styles.numberText}>+</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(1, 1)}
                    >
                    <Text style={styles.numberText}>+</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(2, 1)}
                    >
                    <Text style={styles.numberText}>+</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(3, 1)}
                    >
                    <Text style={styles.numberText}>+</Text>
                </TouchableOpacity>
            </View>

            <View style={styles.rowView}>
                <Text style={styles.numberText}>{pedestrianCount[0]}</Text>
                <Text style={styles.numberText}>{pedestrianCount[1]}</Text>
                <Text style={styles.numberText}>{pedestrianCount[2]}</Text>
                <Text style={styles.numberText}>{pedestrianCount[3]}</Text>
            </View>

            <View style={styles.rowView}>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(0, -1)}
                    >
                    <Text style={styles.numberText}>–</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(1, -1)}
                    >
                    <Text style={styles.numberText}>–</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(2, -1)}
                    >
                    <Text style={styles.numberText}>–</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => updateCount(3, -1)}
                    >
                    <Text style={styles.numberText}>–</Text>
                </TouchableOpacity>
            </View>
            <View>
                <TouchableOpacity
                    style={styles.buttonConfig}
                    onPress={() => newDataPoint()}
                    >
                    <Text style={styles.numberText}>Export</Text>
                </TouchableOpacity>
            </View>
            <View>
                <Text style={styles.standardText}>{latestDataPoint}</Text>
            </View>
            <View>
                <Text style={styles.standardText}>Field Notes:</Text>
            </View>
            <View>
                <TextInput
                    style={styles.inputConfig}
                    placeholderTextColor="#eeeeee"
                    placeholder="Enter field notes here..."
                    textAlign="left"
                    multiline={true}
                />
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        backgroundColor: "#111111"
    },
    rowView: {
        alignItems: "center",
        flexDirection: "row",
        columnGap: 20,
    },
    numberText: {
        fontSize: 25,
        padding: 20,
        color: "#eeeeee",
    },
    headerText: {
        fontSize: 50,
        color: "#eeeeee",
    },
    standardText: {
        fontSize: 20,
        color: "#eeeeee",
    },
    buttonConfig: {
        backgroundColor: "#ff0000",
        borderRadius: 10,
    },
    inputConfig: {
        borderColor: "#eeeeee",
        color: "#eeeeee",
        fontSize: 20,
    },
});