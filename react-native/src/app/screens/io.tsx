import {
    Text,
    View,
    StyleSheet
} from "react-native";

import common from "../style/common";

export default function dataioscreen() {
    return (
        <View style={common.container}>
            <View>
                <Text style={common.headerText}>Data</Text>
            </View>
            <View>
                <Text style={common.standardText}>Coming Soon...</Text>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    standardText: {
            fontSize: 20,
            color: "#eeeeee",
    },
});