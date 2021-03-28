<?xml version="1.0" encoding="utf-8" ?><Configuration>    <ViewDefinitions>

        <View>
            <Name>MachineInfo</Name>
            <ViewSelectedBy>
                <TypeName>Toolmaking.MachineInfo</TypeName>
            </ViewSelectedBy>

            <TableControl>
                <TableHeaders>

                    <TableColumnHeader>
                        <Label>ComputerName</Label>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>OSVersion</Label>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>Model</Label>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>Cores</Label>
                        <Alignment>Right</Alignment>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>RAM</Label>
                        <Alignment>Right</Alignment>
                    </TableColumnHeader>

                </TableHeaders>

                <TableRowEntries>
                    <TableRowEntry>
                        <TableColumnItems>

                            <TableColumnItem>
                                <PropertyName>ComputerName</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>OSVersion</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>Model</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>Cores</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>RAM</PropertyName>
                            </TableColumnItem>

                        </TableColumnItems>
                    </TableRowEntry>
                 </TableRowEntries>
            </TableControl>
        </View>   
    </ViewDefinitions></Configuration>